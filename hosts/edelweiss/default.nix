{
  pkgs,
  self,
  inputs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./powersave.nix
    ./disko.nix
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
  ];

  boot = {
    kernelModules = [ "i2c-dev" ];
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelParams = [
      "amd_pstate=active"
      "ideapad_laptop.allow_v4_dytc=Y"
      ''acpi_osi="Windows 2020"''
      "amdgpu.dcfeaturemask=0x8"
    ];
  };

  # nh default flake
  environment.variables.NH_FLAKE = "/home/xaolan/Documents/code/dotfiles";

  networking.hostName = "edelweiss";

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;
  };
}
