{
  pkgs,
  lib,
  config,
  ...
}: {
  options.ionia.graphics.intel.enable = lib.mkEnableOption "intel graphics";
  config = lib.mkIf (config.ionia.graphics.intel.enable && config.ionia.graphics.enable) {
    # WARN too lazy to futher modularize this maybe re use nixos-hardware's module
    hardware.graphics.extraPackages = with pkgs; [
      libva
      intel-media-driver
      intel-compute-runtime-legacy1
    ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      LIBVA_DRIVERS_PATH = "${pkgs.intel-media-driver}/lib/dri";
      VKD_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd/x86_64.json";
      OCL_ICD_VENDORS = "${pkgs.intel-compute-runtime-legacy1}/etc/OpenCL/vendors";
    };
  };
}
