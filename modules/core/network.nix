{ pkgs, ...}: {
  # // Network //
  networking = {   # Configure network connections interactively with nmcli or nmtui.

    hostName = "nixos";
    networkmanager.enable = true;

    extraHosts = 
    ''
      ${builtins.readFile ./extrahosts}
    '';

  };
}
