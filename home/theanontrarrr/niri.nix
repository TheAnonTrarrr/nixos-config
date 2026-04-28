{ pkgs, config, lib, inputs, ... }:

{

  imports = [
    inputs.niri.homeModules.niri
  ];

  home.packages = with pkgs; [
    niri
    xwayland-satellite
    xwayland
    wayland-utils
    fuzzel
  ];

  programs.niri = {
    settings = {
      spawn-at-startup = [
        { command = [ "xwayland-satellite" ]; }
        { command = [ "noctalia-shell" ]; }
      ];

      input = {
        keyboard.repeat-delay = 250;
        keyboard.repeat-rate = 30;
        mouse.accel-speed = 0;
      };

      outputs."HDMI-A-5" = {
        mode = { width = 1920; height = 1080; refresh = 74.97; };
      };

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
        "Mod+D".action = spawn "fuzzel";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;
      
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
      };

      layout = {
        gaps = 12;
        center-focused-column = "on-overflow";
        # border.width = 2;
        focus-ring = {
          enable = true;
          width = 2;
        };
      };
      
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
        }
      ];
      
      animations = {
        enable = true;
        # Damping-ratio: 1.0 is no bounce, 0.5 is very bouncy. 
        # Stiffness: Higher is faster.
        # spring = { damping-ratio = 0.8; stiffness = 1000; };
      };
    };
  };
}
