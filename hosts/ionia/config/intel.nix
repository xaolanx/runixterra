{
  pkgs,
  self',
  ...
}: {
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [
    pkgs.intel-media-driver
    pkgs.libvdpau-va-gl
    pkgs.intel-ocl
    pkgs.intel-compute-runtime-legacy1
    pkgs.libva
    pkgs.vulkan-tools
    self'.packages.intel-media-sdk-drv
  ];
  hj.environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    LIBVA_DRIVERS_PATH = "${pkgs.intel-media-driver}/lib/dri";
    VKD_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd/x86_64.json";
    OCL_ICD_VENDORS = "${pkgs.intel-compute-runtime-legacy1}/etc/OpenCL/vendors";
    ANV_DEBUG = "video-decode";
    ANV_VIDEO_DECODE = "1";
  };
}
