{ pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      
      gaps = {
        inner = 10;
        outer = 5;
      };

      window.border = 1;
      
      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3status}/bin/i3status";
        fonts = {
          names = [ "FiraCode Nerd Font" ];
          size = 10.0;
        };
      }];

      startup = [
        { command = "picom -b"; notification = false; }
        { command = "feh --bg-fill ~/nixos-config/wallpaper_1.png"; notification = false; }
      ];
    };
  };
}
