{ pkgs, config, lib, inputs, ... }:

{

  imports = [
    inputs.niri.homeModules.niri
  ];

  home.packages = with pkgs; [
    niri
    xwayland
    wayland-utils
    fuzzel
  ];

  programs.niri = {
    settings = {
      spawn-at-startup = [
        { command = [ "${pkgs.noctalia-shell}/bin/noctalia-shell" ]; }
      ];

      outputs."HDMI-A-1" = {
        mode = { width = 1920; height = 1080; refresh = 74.97; };
      };

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
        "Mod+D".action = spawn "dmenu-wl";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;
      
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
      };

      layout = {
        gaps = 10;
        border.width = 2;
        focus-ring.enable = true;
        center-focused-column = "on-overflow";
      };
    };
  };
}
