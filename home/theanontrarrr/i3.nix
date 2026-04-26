{ pkgs, ... }: {

let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    DMENU="${pkgs.dmenu}/bin/dmenu"
    I3MSG="${pkgs.i3}/bin/i3-msg"
    TERMINAL="${pkgs.kitty}/bin/kitty"

    options="Logout\nRebuild\nReboot\nShutdown"
    chosen=$(echo -e "$options" | $DMENU -p "Action:")

    case "$chosen" in
      Logout) $I3MSG exit ;;
      Rebuild) $TERMINAL -e bash -c "sudo nixos-rebuild switch --flake ./nixos-config#nixos; read -p 'Done!'" ;;
      Reboot) systemctl reboot ;;
      Shutdown) systemctl poweroff ;;
    esac
  '';
in

  home.packages = [ powermenu ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      
      keybindings = let
        modifier = "Mod4";
      in pkgs.lib.mkOptionDefault {

        "${modifier}+Shift+p" = "exec powermenu";
        
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
