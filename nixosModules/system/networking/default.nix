{
  lib,
  config,
  ...
}: {
  imports = [
    ./bluetooth.nix
    ./dnsproxy2.nix
  ];

  config = lib.mkIf (!config.ionia.data.headless) {
    networking = {
      nameservers = ["9.9.9.9#dns.quad9.net"];
      nftables.enable = true;
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi = {
          powersave = false;
          macAddress = "random";
        };
      };

      firewall = {
        enable = true;
        allowedTCPPortRanges = [];
        allowedUDPPortRanges = [];
      };
    };
  };
}
