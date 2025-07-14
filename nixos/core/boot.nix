{
  pkgs,
  config,
  ...
}: {
  boot = {
    bootspec.enable = true;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4" "btrfs" "vfat" "ntfs"];
    };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];

    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };

    plymouth.enable = true;
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
