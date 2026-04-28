# /////////////////////////
# //                     //
# //    Home-Manager     //
# //                     //
# //      home.nix       //
# //                     //
# /////////////////////////

{ config, pkgs, ... }:

{

  imports = [
    ./fonts.nix
    ./i3.nix
    ./niri.nix
    ./noctalia.nix
  ];

  # // Basic Configuration //
  home.username = "theanontrarrr";
  home.homeDirectory = "/home/theanontrarrr";


  # // Version (DO NOT CHANGE) //
  home.stateVersion = "25.11";

  programs = {
    git = {
      enable = true;
      settings.user.name = "TheAnonTrarrr";
      settings.user.email = "208259891+TheAnonTrarrr@users.noreply.github.com";
    };
    kitty = {
      enable = true;
    };
  };

  # // User Packages //
  home.packages = [

    pkgs.telegram-desktop
    pkgs.discord
    pkgs.qbittorrent
    pkgs.xclip
    pkgs.wl-clipboard
    pkgs.xrandr
    pkgs.pavucontrol
    pkgs.yazi
    pkgs.thunar
  ];

  services.flameshot.enable = true;
  
  xdg.configFile."kitty/kitty.conf".text = ''
  background #000000
  foreground #ebdbb2
  cursor     #ebdbb2
  selection_foreground #000000
  selection_background #dfbf8e
  color0     #000000
  color8     #928374
  color1     #fb4934
  color9     #fb4934
  color2     #b8bb26
  color10    #b8bb26
  color3     #d79921
  color11    #fabd2f
  color7     #a89984
  color15    #ebdbb2
  confirm_os_window_close 0
  window_padding_width 10
  '';

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Material-Dark-Soft";
      package = pkgs.gruvbox-material-gtk-theme;
    };
    iconTheme = {
      name = "Gruvbox-Material-Dark-Soft";
      package = pkgs.gruvbox-plus-icons;
    };
    gtk4.theme = null;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

}
