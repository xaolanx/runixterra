{
  pkgs,
  config,
  lib,
  ...
}: {
  options.ionia.graphics.amd.enable = lib.mkEnableOption "amd graphics";

  config = lib.mkIf (config.ionia.graphics.amd.enable && config.ionia.graphics.enable) {
    environment.systemPackages = [pkgs.radeontop];
    hardware.graphics = {
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr.icd
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
    };

    services.xserver.videoDrivers = ["amdgpu"];

    # amd hip workaround
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
