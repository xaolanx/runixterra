{
  pkgs,
  config,
  ...
}: let
  inherit (config.local.vars.system) username;
in {
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };

    plymouth = {
      enable = true;
      extraConfig = ''
        [Daemon]
        DeviceScale=2
      '';
    };

    consoleLogLevel = 0;
    initrd.systemd.enable = true;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
  };
  system.nixos.distroName = "Runixterra";
  environment.etc.issue = {
    # a disgusting mess of escape codes to make it look nice. extra line on purpose for spacing.
    source = pkgs.writeText "issue" ''
      \e[32mWelcome to the fold of Runixterra, \e[36m${username}\e[1;32m. \e[2m(\l)\e[0m

    '';
  };

  systemd.tpm2.enable = false;
}
