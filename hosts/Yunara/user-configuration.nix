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

  packages = with pkgs; [
    wineWowPackages.stable
    bottles
    winetricks
    foot
    audacious
    tidal-hifi
    youtube-music
    micro
    ripgrep
    telegram-desktop
    zen-browser
    braveWithFlags
    mpv-wrapped
    scripts.wallcrop
    discord
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
    wallpaper = let
      url = "https://github.com/rose-pine/wallpapers/blob/main/bay.JPG?raw=true";
      sha256 = "YLHsj9SKuJNwiYxCQ5zFDrdEfTSEH89ue95yBvQZ+MI=";
      ext = "jpg";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
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
