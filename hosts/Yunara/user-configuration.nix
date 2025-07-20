{
  pkgs,
  lib,
  config,
  ...
}: let
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

  packages = [
    pkgs.wineWowPackages.stable
    pkgs.bottles
    pkgs.winetricks
    pkgs.foot
    pkgs.audacious
    pkgs.micro
    pkgs.ripgrep
    pkgs.telegram-desktop
    braveWithFlags

    # from internal overlay
    pkgs.mpv-wrapped
    pkgs.scripts.wallcrop
    pkgs.discord # yes this is vesktop
  ];
in {
  imports = [../../nixosModules/external/matugen];

  users.users."xaolan" = {
    inherit packages;
    extraGroups = [
      "video"
      "input"
      "transmission"
      "plugdev"
      "wheel"
      "libvirt"
      "networkmanager"
    ];
  };

  programs.matugen = {
    enable = true;
    # wallpaper = config.programs.booru-flake.images."8827425";
    wallpaper = let
      image = config.programs.booru-flake.images."6887138";
    in
      pkgs.stdenv.mkDerivation {
        name = "cropped-${image.name}";
        src = image;
        dontUnpack = true;
        nativeBuildInputs = [pkgs.imagemagick];
        installPhase = ''
          magick $src -crop 1920x1080+600+1200 - > $out
        '';
      };
  };

  hjem.users."xaolan".files = {
    ".face.icon".source = let
      image = config.programs.booru-flake.images."6885267";
      face = pkgs.stdenv.mkDerivation {
        name = "cropped-${image.name}";
        src = image;
        dontUnpack = true;
        nativeBuildInputs = [pkgs.imagemagick];
        installPhase = ''
          magick $src -crop 450x450+640+25 - > $out
        '';
      };
    in
      lib.mkForce face;

    "Pictures/booru".source = config.programs.booru-flake.imageFolder;
  };
}
