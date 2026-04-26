{ pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      
      keybindings = let
        modifier = "Mod4";
      in pkgs.lib.mkOptionDefault {

        "${modifier}+Shift+p" = "exec \"echo -e 'Logout\\nRebuild\\nReboot\\nShutdown' | dmenu -p 'Action:' | xargs -I{} bash -c 'if [ \\\"{}\\\" == \\\"Logout\\\" ]; then i3-msg exit; elif [ \\\"{}\\\" == \\\"Rebuild\\\" ]; then sudo nixos-rebuild switch --flake .#nixos; elif [ \\\"{}\\\" == \\\"Reboot\\\" ]; then reboot; elif [ \\\"{}\\\" == \\\"Shutdown\\\" ]; then poweroff; fi'\"";
        
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
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
