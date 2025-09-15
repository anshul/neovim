# Example overlay:
/*
importName: inputs: let
  overlay = self: super: {
    ${importName} = SOME_DRV;
    # or
    ${importName} = {
      # define your overlay derivations here
    };
  };
in
overlay
*/
inputs: let
  inherit (inputs.nixCats) utils;
  overlaySet = {
    tailwindcss = import ./tailwindcss.nix;
    obsidian = import ./obsidian.nix;
    # example = import ./example.nix;
    # deepwiki = import ./deepwiki.nix; # Commented out temporarily - community plugin may not be available
  };
  extra = [
    (utils.sanitizedPluginOverlay inputs)
  ];
in
  builtins.attrValues (builtins.mapAttrs (name: value: (value name inputs)) overlaySet) ++ extra
