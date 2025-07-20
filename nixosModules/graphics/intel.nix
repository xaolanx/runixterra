{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkPackageOption getExe;
  cfg = config.ionia.graphics.intel;
in {
  options.ionia.graphics.intel = {
    enable = mkEnableOption "intel graphics";
    intelQSVprovider = mkPackageOption pkgs "QSV provider" {
      default = "intel-media-driver";
    };
  };
  config = mkIf (cfg.enable && config.ionia.graphics.enable) {
    hardware.graphics.extraPackages = [
      cfg.intelQSVprovider
      pkgs.intel-vaapi-driver
      pkgs.libvdpau-va-gl
      pkgs.intel-ocl
      pkgs.intel-compute-runtime-legacy1
      pkgs.libva
      pkgs.vpl-gpu-rt
    ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      LIBVA_DRIVERS_PATH = "${pkgs.intel-media-driver}/lib/dri";
      VKD_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd/x86_64.json";
      OCL_ICD_VENDORS = "${pkgs.intel-compute-runtime-legacy1}/etc/OpenCL/vendors";
    };

    security.wrappers.btop = {
      owner = "root";
      group = "root";
      source = getExe pkgs.btop;
      capabilities = "cap_perfmon+ep";
    };
  };
}
