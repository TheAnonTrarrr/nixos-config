{ pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      
      keybindings = let
        modifier = "Mod4";
      in pkgs.lib.mkOptionDefault {

        "${modifier}+Shift+p" = "exec ~/.config/i3/scripts/powermenu.sh";
        
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
 
        "${modifier}+l" = "exec ${pkgs.i3lock}/bin/i3lock -c 000000";
      };

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
        { command = "feh --bg-fill ~/nixos-config/wallpapers/wallpaper_1.png"; notification = false; }
      ];
    };
  };
}
