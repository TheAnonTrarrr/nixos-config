{ pkgs, ...}: {
  # // Network //
  networking = {

    hostName = "nixos";
    networkmanager.enable = true;

    extraHosts = 
    ''
      ${builtins.readFile ./extrahosts}
    '';

    firewall.trustedInterfaces = [ "virbr0" ];

  };  

  boot.kernelModules = [ "tun" "tap" ];

}
