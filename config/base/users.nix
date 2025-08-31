{
  lib,
  config,
  pkgs,
  self,
  pins,
  options,
  ...
}: let
  inherit (lib.modules) mkAliasOptionModule;
  inherit (config.local.vars.home) fullName;
  inherit (config.local.vars.system) username;

  rumLib = import (pins.hjem-rum + "/modules/lib/default.nix") {inherit lib;};
  hjemRumModule = import (pins.hjem-rum + "/modules/hjem.nix") {
    inherit lib rumLib;
  };
in {
  imports = [
    (lib.modules.importApply "${pins.hjem}/modules/nixos" {
      inherit pkgs config lib options;
      hjem-lib = import "${pins.hjem}/lib.nix" {inherit lib pkgs;};
    })

    # avoid boilerplate in the configuration
    (mkAliasOptionModule ["hj"] ["hjem" "users" username])
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = fullName;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "audio"
      "video"
      "wheel"
      "plugdev"
    ];
  };

  hjem = {
    clobberByDefault = true;
    extraModules = [
      self.hjemModules.xdg-autostart
      hjemRumModule
    ];

    users.${username} = {
      enable = true;
      directory = "/home/${username}";
      user = "${username}";
    };

    linker = pkgs.smfh;
  };
}
