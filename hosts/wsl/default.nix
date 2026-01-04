{ inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];
  # nh default flake
  environment.variables.NH_FLAKE = "/home/xaolan/Documents/code/dotfiles";

  wsl = {
    enable = true;
    defaultUser = "xaolan";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
