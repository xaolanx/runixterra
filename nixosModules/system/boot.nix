{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (!config.ionia.data.headless) {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      supportedFilesystems = ["ntfs"];

      loader.timeout = 0;
    };
  };
}
