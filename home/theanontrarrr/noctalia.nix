{ inputs, pkgs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = [ inputs.noctalia.packages.${pkgs.system}.default ];

  programs.noctalia-shell = {
    enable = true;
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
