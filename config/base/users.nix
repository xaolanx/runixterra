{
  inputs,
  lib,
  config,
  pkgs,
  inputs',
  self,
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

  age.identityPaths = ["${config.hj.directory}/.ssh/id_ed25519"];
  hjem = {
    clobberByDefault = true;
    extraModules = [
      inputs.hjem-rum.hjemModules.default
      self.hjemModules.xdg-autostart
    ];
    users.${username} = {
      enable = true;
      directory = "/home/${username}";
      user = "${username}";
    };

    linker = inputs'.hjem.packages.smfh;
  };
}
