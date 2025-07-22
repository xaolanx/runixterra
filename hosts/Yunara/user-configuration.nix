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
    fooyin
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
      url = "https://konachan.net/image/84b87b18c439e814bce2e67e159a5d2c/Konachan.com%20-%20390718%20animal%20barefoot%20blonde_hair%20blue_eyes%20breasts%20clouds%20czk%20dark%20dress%20fish%20flowers%20headdress%20leaves%20long_hair%20night%20ruins%20sideboob%20sky%20tree%20wristwear.jpg";
      sha256 = "sha256-hqNm19vxlLYvaVNe6i1Ogs1FHmGb7HiYywHzxQlE6xU=";
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
