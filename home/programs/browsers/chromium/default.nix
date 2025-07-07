{...}: let
  # Common extensions for both browsers
  commonExtensions = [
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    "fnaicdffflnofjppbagibeoednhnbjhg" # floccus
    "aleakchihdccplidncghkekgioiakgal" # h264ify
    "icallnadddjmdinamnolclfjanhfoafe" # fastforward
    "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
    "dhdgffkkebhmkfjojejmpbldmpobfkfo" # tampermonkey
    "ldgfbffkinooeloadekpmfoklnobpien" # raindrop
    "lckanjgmijmafbedllaakclkaicjfmnk" # clearurl's
    "ghbmnnjooekpmoecnnnilnnbdlolhkhi" # google doc's offline
    "naipgebhooiiccifflecbffmnjbabdbh" # hhyperchat
    "mfpkbigjnlcgngkdbmnchfnenfmibkig" # yt inline fullscreen
    "dggbkbndbcaknaeobfieifmdcncmpaba" # yt fast fullscreen
    "nlkaejimjacpillmajjnopmpbkbnocid" # yt nonstop
    "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
    "eppiocemhmnlbhjplcgkofciiegomcon" # urban vpn
  ];

  # Common command line flags for both browsers
  commonCommandLineArgs = [
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
in {
  # Configure Chromium browser
  programs.google-chrome = {
    enable = false;
    commandLineArgs = commonCommandLineArgs;
  };

  # Configure Brave browser
  programs.brave = {
    enable = true;
    commandLineArgs = commonCommandLineArgs;
    extensions = commonExtensions;
  };
}
