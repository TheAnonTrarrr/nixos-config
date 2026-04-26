# ./home/theanontrarrr/scripts/powermenu.sh
#!/bin/bash

# Define the options
options="Logout\nRebuild\nReboot\nShutdown"

# Get the choice from dmenu
chosen=$(echo -e "$options" | dmenu -p "Action:" -nb "#222222" -nf "#bbbbbb" -sb "#444444" -sf "#ffffff")

# Execute the choice
case "$chosen" in
    Logout) i3-msg exit ;;
    Rebuild) alacritty -e bash -c "sudo nixos-rebuild switch --flake .#nixos; read -p 'Press enter to continue'" ;;
    Reboot) reboot ;;
    Shutdown) poweroff ;;
esac
