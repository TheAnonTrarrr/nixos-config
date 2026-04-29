{ pkgs, config, ... }: {
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    modesetting.enable = true;    
    powerManagement.finegrained = false;
    # package = config.boot.kernelPackages.nvidiaPackages.vgpu_17_3;
    vgpu = {
      patcher.enable = true;
    };
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
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
  '';
}
