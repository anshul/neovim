name: inputs: let
  inherit (inputs.nixCats) utils;
in
  self: super: {
    neovimPlugins =
      super.neovimPlugins
      // {
        deepwiki-nvim = utils.buildNeovimPlugin self {
          pname = "deepwiki.nvim";
          version = "2024-12-27";
          src = self.fetchFromGitHub {
            owner = "ofseed";
            repo = "deepwiki.nvim";
            rev = "main";
            sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
          meta = with self.lib; {
            description = "Wikipedia search and MCP DeepWiki integration for Neovim";
            homepage = "https://github.com/ofseed/deepwiki.nvim";
            license = licenses.mit;
            maintainers = [];
          };
        };
      };
  }
