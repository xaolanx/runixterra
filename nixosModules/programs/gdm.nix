# NOTE not imported
{
  lib,
  config,
  ...
}: {
  options.ionia.programs.gdm.enable = lib.mkEnableOption "gdm";
  config = lib.mkIf config.ionia.programs.gdm.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
      wayland = true;
      settings = {
        greeter = {
          Include = builtins.concatStringsSep "," config.ionia.data.users;
        };
      };
      banner = ''こんにちは'';
    };

    systemd.tmpfiles.rules = lib.pipe config.ionia.data.users [
      (builtins.filter (user: config.hjem.users.${user}.files.".face.icon".source != null))
      (builtins.map (user: [
        "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
        "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${config.hjem.users.${user}.files.".face.icon".source}"
      ]))
      (lib.flatten)
    ];
  };
}
