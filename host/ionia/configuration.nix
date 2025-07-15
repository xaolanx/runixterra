{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  boot = {
    kernelModules = [
      "i915"
      "intel_rapl_common"
      "intel_powerclamp"
      "industrialio"
      "industrialio_triggered_buffer"
      "kfifo_buf"
      "i2c_i801"
      "i2c_smbus"
      "i2c-dev"
      "intel_soc_dts_iosf"
      "intel_thermal"
      "bmc150_accel_i2c"
      "bmc150_magn_i2c"
      "bmi160_i2c"
      "hid_sensor_gyro_3d"
      "hid_sensor_accel_3d"
      "hid_sensor_iio_common"
    ];

    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    kernelParams = [
      "i915.force_probe=0x5a85"
      "i915.enable_psr=1"
      "i915.enable_fbc=1"
      "intel_idle.max_cstate=1"
      "pcie_aspm=force"
    ];
  };

  services = {
    fstrim.enable = true;
  };

  hardware.sensor.iio.enable = true;

  networking.hostName = "ionia";

  security.tpm2.enable = true;
}
