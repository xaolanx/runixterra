{pkgs, ...}: let
  commandLineArgs = [
    "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,CanvasOopRasterization,DefaultANGLEVulkan,EnableDrDc,SkiaGraphite,Vulkan,VulkanFromANGLE,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo,UseOzonePlatform,VaapiIgnoreDriverChecks"
    "--ozone-platform=wayland"
    "--disable-features=UseChromeOSDirectVideoDecoder"
    "--ignore-gpu-blocklist"
    "--enable-zero-copy"
    "--disable-gpu-driver-bug-workarounds"
    "--enable-gpu-rasterization"
    "--enable-unsafe-webgpu"
    "--ozone-platform-hint=wayland"
  ];
in {
  hj.packages = [
    (pkgs.brave.override {
      inherit commandLineArgs;
    })
  ];
}
