{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkForce;
in {
  imports = [
    ./hardware-configuration.nix
    ./user-configuration.nix
    ./disko.nix
    ./boot.nix
    # ./extras/privoxy.nix
    # ./extras/lanzaboote.nix
  ];

  system.stateVersion = "24.11";
  networking.hostName = "Yunara";
  time.timeZone = "Asia/Jakarta";

  ionia = {
    graphics = {
      enable = true;
      intel.enable = true;
    };

    programs = {
      sddm-custom-theme.enable = true;
      obs-studio.enable = false;
      steam.enable = true;
      hyprland.enable = true;
      keyd.enable = false;
      firefox.enable = true;
    };

    services = {
      enable = true;
      tailscale = {
        enable = false;
        exitNode.enable = false;
      };
      openssh = {
        enable = true;
      };
    };
  };

  # tailscale
  # age.secrets.tailAuth.file = ../../secrets/secret9.age;
  # services.tailscale.authKeyFile = config.age.secrets.tailAuth.path;

  # forward dns onto the tailnet
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53];
  # services.dnscrypt-proxy2.settings = {
  #   listen_addresses = [
  #     "100.110.70.18:53"
  #     "[fd7a:115c:a1e0::6a01:4614]:53"
  #     "127.0.0.1:53"
  #     "[::1]:53"
  #   ];
  # };

  # generic
  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
  };

  hardware.bluetooth.powerOnBoot = mkForce false;

  # finger print
  # systemd.services.fprintd = {
  #   wantedBy = ["multi-user.target"];
  #   serviceConfig.Type = "simple";
  # };
  # services.fprintd = {
  #   enable = true;
  #   tod.enable = true;
  #   tod.driver = pkgs.libfprint-2-tod1-elan;
  # };

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.xaolan.extraGroups = ["podman"];

  # disable network manager wait online service (+6 seconds to boot time!!!!)
  systemd.services.NetworkManager-wait-online.enable = false;
}
