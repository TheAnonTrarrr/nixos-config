{ pkgs, ...}: {

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  systemd.services.libvirt-suspend-vms = {
    description = "Managed save of all VMs before sleep";
    before = [ "systemd-suspend.service" "systemd-hibernate.service" ];
    wantedBy = [ "systemd-suspend.service" "systemd-hibernate.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.libvirt}/bin/virsh managed-save-all";
    };
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 theanontrarrr libvirtd -"
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
  ];

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
  '';

  boot.kernelParams = [ 
    "intel_iommu=on" 
    "iommu=pt"
  ];


}
