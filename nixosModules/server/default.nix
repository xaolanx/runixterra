{lib, ...}: {
  imports = [
    ./tailscale.nix
    # ./immich.nix
    ./openssh.nix
    # ./jellyfin.nix
    # ./fail2ban.nix

    # meh not used anywhere for now
    # ./minecraft
  ];

  options.ionia.services.enable = lib.mkEnableOption "services";
}
