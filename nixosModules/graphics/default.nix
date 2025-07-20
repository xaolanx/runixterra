{
  lib,
  config,
  ...
}: {
  imports = [
    ./amd.nix
    ./nvidia.nix
    ./intel.nix
  ];

  options.ionia.graphics.enable = lib.mkEnableOption "graphics";

  config = lib.mkIf (config.ionia.graphics.enable) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
