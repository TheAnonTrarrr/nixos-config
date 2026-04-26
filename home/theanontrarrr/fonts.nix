{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    fira-code
    noto-fonts
    noto-fonts-color-emoji
  ];

  # This enables font discovery for applications
  fonts.fontconfig.enable = true;
}
