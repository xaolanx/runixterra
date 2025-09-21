{
  lib,
  config,
  pkgs,
  self,
  inputs,
  ...
}: let
  inherit (lib.modules) mkAliasOptionModule;
  inherit (config.local.vars.home) fullName;
  inherit (config.local.vars.system) username;
in {
  imports = [
    inputs.hjem.nixosModules.default
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
      inputs.hjem-rum.hjemModules.default
    ];

    users.${username} = {
      enable = true;
      directory = "/home/${username}";
      user = "${username}";
    };

    linker = pkgs.smfh;
  };
}
