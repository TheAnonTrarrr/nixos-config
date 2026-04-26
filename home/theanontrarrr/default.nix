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
    pkgs.copyq
    pkgs.pcmanfm
    pkgs.xrandr
    pkgs.pavucontrol

  ];

  home.shellAliases = {
    nix-switch = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    nix-push = "git -C ~/nixos-config add . && git -C ~/nixos-config commit -m 'update' && git -C ~/nixos-config push";
  };

  services.flameshot.enable = true;

  home.file = {
    ".config/openbox/autostart".text = ''
      picom --backend glx --use-damage &
      tint2 &
      feh --bg-fill ~/Pictures/wallpaper_1.png &
      copyq &
    '';
  }; 
  
  xdg.configFile."openbox/rc.xml".text = ''
  <?xml version="1.0" encoding="UTF-8"?>
  <openbox_config xmlns="http://openbox.org/3.4/rc">
    <focus>
      <focusNew>yes</focusNew>
      <followMouse>no</followMouse>
      <focusLast>yes</focusLast>
      <underMouse>no</underMouse>
    </focus>

    <keyboard>
      <chainQuitKey>C-g</chainQuitKey>

      <keybind key="A-Return">
        <action name="Execute"><command>kitty</command></action>
      </keybind>

      <keybind key="A-d">
        <action name="Execute"><command>rofi -show drun</command></action>
      </keybind>

      <keybind key="A-q">
        <action name="Close"/>
      </keybind>
    
      <keybind key="W-Left"><action name="UnmaximizeFull"/><action name="MoveResizeTo"><x>0</x><y>0</y><width>50%</width><height>100%</height></action></keybind>
      <keybind key="W-Right"><action name="UnmaximizeFull"/><action name="MoveResizeTo"><x>50%</x><y>0</y><width>50%</width><height>100%</height></action></keybind>

      <keybind key="Print">
        <action name="Execute">
          <command>flameshot gui</command>
        </action>
      </keybind>
    </keyboard>

    <mouse>
      <context name="Client">
        <mousebind button="Left" action="Press">
          <action name="Focus"/>
          <action name="Raise"/>
        </mousebind>
      </context>

      <context name="Titlebar">
        <mousebind button="Left" action="Press">
          <action name="Focus"/>
          <action name="Raise"/>
        </mousebind>
        <mousebind button="Left" action="Drag">
          <action name="Move"/>
        </mousebind>
      </context>

      <context name="Root">
        <mousebind button="Right" action="Press">
          <action name="ShowMenu">
            <menu>root-menu</menu>
          </action>
        </mousebind>
      </context>

      <context>
        <mousebind button="A-Left" action="Press">
          <action name="Focus"/>
          <action name="Raise"/>
        </mousebind>
        <mousebind button="A-Left" action="Drag">
          <action name="Move"/>
        </mousebind>
        <mousebind button="A-Right" action="Press">
          <action name="Focus"/>
          <action name="Raise"/>
          <action name="Unshade"/>
        </mousebind>
        <mousebind button="A-Right" action="Drag">
          <action name="Resize"/>
        </mousebind>
      </context>
    </mouse>

    <menu>
      <file>menu.xml</file>
    </menu>

    <resize>
      <drawContent>yes</drawContent>
      <popupShow>Never</popupShow>
    </resize>

    <theme>
      <name>Clearlooks</name>
      <cornerRadius>4</cornerRadius>
    </theme>
  </openbox_config>
  '';

  xdg.configFile."openbox/menu.xml".text = ''
  <?xml version="1.0" encoding="UTF-8"?>
  <openbox_menu xmlns="http://openbox.org/3.4/menu">
    <menu id="root-menu" label="Openbox 3">
      <item label="Kitty Terminal"><action name="Execute"><command>kitty</command></action></item>
      <item label="Web Browser"><action name="Execute"><command>firefox</command></action></item>
      <separator />
      <item label="Tint2 Settings"><action name="Execute"><command>tint2conf</command></action></item>
      <item label="Reconfigure Openbox"><action name="Reconfigure" /></item>
      <separator />
      <item label="Suspend NixOS"><action name="Execute"><command>systemctl suspend</command></action></item>
      <item label="Restart NixOS"><action name="Execute"><command>systemctl reboot</command></action></item>
      <item label="Shutdown NixOS"><action name="Execute"><command>systemctl shutdown</command></action></item>
      <separator />
      <item label="Exit OpenBox"><action name="Exit" /></item>
    </menu>
  </openbox_menu>
  '';

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
