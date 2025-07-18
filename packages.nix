inputs: let
  inherit (inputs.nixCats) utils;
in {
  nvim = {
    pkgs,
    name,
    ...
  } @ misc: {
    settings = {
      suffix-path = true;
      suffix-LD = true;
      wrapRc = true;
      configDirName = "nvim";
      hosts.node.enable = true;
      hosts.ruby.enable = true;
      hosts.python3.enable = true;
      aliases = ["vim"];
      # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    };
    categories = {
      general = true;
      extra = true;
      gitPlugins = true;
      test = true;
      elixir = true;
    };
    extra = {
      nixdExtras = {
        nixpkgs = "import ${pkgs.path} {}";
      };
    };
  };
}
