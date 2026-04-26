{ pkgs, ... }: {
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    modesetting.enable = true;    
  };
  services.xserver = {
    screenSection = ''
      Option "metamodes" "1920x1080_75 +0+0"
      Option "DPI" "96 x 96"
    '';
    deviceSection = ''
      Option "ModeValidation" "AllowNonEdidModes"
    '';
  };
}
