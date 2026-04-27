{ inputs, pkgs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      bar = {
        position = "top";
        widgets = {
          left = [ { id = "ControlCenter"; } { id = "Network"; } ];
          center = [ { id = "Workspace"; } ];
          right = [ { id = "Battery"; } { id = "Clock"; } ];
        };
      };
      general.radiusRatio = 0.2;
    };
  };
}
