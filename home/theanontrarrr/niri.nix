{ pkgs, ... }:

{
  home.packages = with pkgs; [
    niri
    xwayland
    wayland-utils
  ];

  programs.niri.settings = {
    outputs."HDMI-A-1" = {
      mode = { width = 1920; height = 1080; refresh = 74.97; };
    };

    binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";
      "Mod+Q".action = close-window;
      "Mod+Shift+E".action = quit;
      
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
    };

    layout = {
      gaps = 10;
      center-focused-column = true;
    };
  };
}
