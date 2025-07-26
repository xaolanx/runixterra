{pkgs, ...}: let
  braveWithFlags = pkgs.brave.override {
    commandLineArgs = [
      "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,CanvasOopRasterization,DefaultANGLEVulkan,EnableDrDc,SkiaGraphite,Vulkan,VulkanFromANGLE,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo,UseOzonePlatform,VaapiIgnoreDriverChecks"
      "--flag-switches-end"
      "--ozone-platform=wayland"
      "--disable-features=UseChromeOSDirectVideoDecoder"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--disable-gpu-driver-bug-workarounds"
      "--flag-switches-begin"
      "--enable-gpu-rasterization"
      "--enable-unsafe-webgpu"
      "--ozone-platform-hint=wayland"
    ];
  };
in {
  environment.systemPackages = [braveWithFlags];
}
