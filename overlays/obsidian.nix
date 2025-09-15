importName: inputs: let
  overlay = self: super: {
    vimPlugins =
      super.vimPlugins
      // {
        obsidian-nvim = super.vimPlugins.obsidian-nvim.overrideAttrs (oldAttrs: {
          nvimRequireCheck = "obsidian";
        });
      };
  };
in
  overlay
