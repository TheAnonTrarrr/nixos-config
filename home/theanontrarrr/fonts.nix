{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerdfonts
    fira-code
    noto-fonts
    noto-fonts-emoji
  ];

  # This enables font discovery for applications
  fonts.fontconfig.enable = true;
}
