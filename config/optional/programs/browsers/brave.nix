{pkgs, ...}: let
  commandLineArgs = [
    "--enable-features=AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,UseOzonePlatform"
    "--ozone-platform=wayland"
    "--ignore-gpu-blocklist"
    "--enable-zero-copy"
    "--ozone-platform-hint=wayland"
  ];
in {
  hj.packages = [
    (pkgs.brave.override {
      inherit commandLineArgs;
    })
  ];
}
