{
  description = "An opinionated AI-first Nix Neovim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    plugins-lze = {
      url = "github:BirdeeHub/lze";
      flake = false;
    };
    plugins-lzextras = {
      url = "github:BirdeeHub/lzextras";
      flake = false;
    };
    plugins-incline-nvim = {
      url = "github:b0o/incline.nvim";
      flake = false;
    };
    plugins-slimline-nvim = {
      url = "github:sschleemilch/slimline.nvim";
      flake = false;
    };
    plugins-websocket-nvim = {
      url = "github:AbaoFromCUG/websocket.nvim";
      flake = false;
    };
    plugins-possession-nvim = {
      url = "github:jedrzejboczar/possession.nvim";
      flake = false;
    };
    plugins-reactive-nvim = {
      url = "github:rasulomaroff/reactive.nvim";
      flake = false;
    };
    plugins-colorful-winsep-nvim = {
      url = "github:nvim-zh/colorful-winsep.nvim";
      flake = false;
    };
    plugins-symbol-usage-nvim = {
      url = "github:Wansmer/symbol-usage.nvim";
      flake = false;
    };
    plugins-early-retirement-nvim = {
      url = "github:chrisgrieser/nvim-early-retirement";
      flake = false;
    };
    plugins-timber-nvim = {
      url = "github:Goose97/timber.nvim";
      flake = false;
    };
    plugins-maximize-nvim = {
      url = "github:declancm/maximize.nvim";
      flake = false;
    };
    plugins-claude-vim = {
      url = "github:pasky/claude.vim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

    extra_pkg_config = {
      allowUnfree = true;
      doCheck = true; # set to false to skip tests
    };

    dependencyOverlays = import ./overlays inputs;
    categoryDefinitions = import ./categories.nix inputs;
    packageDefinitions = import ./packages.nix inputs;
    defaultPackageName = "nvim";
  in
    forEachSystem (system: let
      nixCatsBuilder =
        utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions;
      defaultPackage = nixCatsBuilder defaultPackageName;
      pkgs = import nixpkgs {inherit system;};
    in {
      packages = utils.mkAllWithDefault defaultPackage;

      checks = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            ruff.enable = true;
            shellcheck.enable = true;
            markdownlint.enable = true;
            alejandra.enable = true;
            stylua.enable = true;
            prettier.enable = true;
          };
        };
      };

      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = with pkgs; [
            # defaultPackage
            just
            nodejs_22
            gh
            entr # for file watching in TDD
            luajit # lua runtime for tests
            luajitPackages.busted # lua testing framework
            luajitPackages.luafilesystem # required by busted
            # Custom build command
            (writeShellScriptBin "build" ''
              nix build .#nvim "$@"
            '')
            # Custom run command
            (writeShellScriptBin "run" ''
              nix run .#nvim "$@"
            '')
          ];
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          shellHook = ''
            ${self.checks.${system}.pre-commit-check.shellHook}

          '';
        };
      };
    })
    // (let
      # we also export a nixos module to allow reconfiguration from configuration.nix
      nixosModule = utils.mkNixosModules {
        moduleNamespace = [defaultPackageName];
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
      # and the same for home manager
      homeModule = utils.mkHomeModules {
        moduleNamespace = [defaultPackageName];
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
    in {
      # these outputs will be NOT wrapped with ${system}
      overlays =
        utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions
        defaultPackageName;

      nixosModules.default = nixosModule;
      homeModules.default = homeModule;

      inherit utils nixosModule homeModule;
      inherit (utils) templates;
    });
}
