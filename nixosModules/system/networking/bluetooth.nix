{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (!config.ionia.data.headless) {
    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
}
