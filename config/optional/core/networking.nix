{config, ...}: {
  networking = {
    inherit (config.local.vars.system) hostName;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
      };
      dns = "systemd-resolved";
    };
  };
  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };
}
