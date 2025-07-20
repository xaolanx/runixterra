{
  lib,
  config,
  ...
}: {
  options.ionia.services.openssh.enable = lib.mkEnableOption "openssh service";
  config = lib.mkIf (config.ionia.services.openssh.enable && config.ionia.services.enable) {
    services.openssh = {
      enable = true;
      openFirewall = true;
      startWhenNeeded = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = config.ionia.data.users;
      };
    };
  };
}
