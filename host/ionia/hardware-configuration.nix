{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "sd_mod" "rtsx_usb_sdmmc" "i915" "usb_storage"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/home/xaolan/Ventoy" = {
    device = "/dev/disk/by-uuid/2488765988762A06";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };

  fileSystems."/home/xaolan/Data1" = {
    device = "/dev/disk/by-uuid/1C8A0A998A0A6F96";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };

  fileSystems."/home/xaolan/Data2" = {
    device = "/dev/disk/by-uuid/ECAA469DAA4663E4";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
