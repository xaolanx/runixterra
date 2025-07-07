{
  pkgs,
  config,
  lib,
  ...
}: let
  pluginsPkgs = {
    autoload = pkgs.mpvScripts.autoload;
    sponsorblock = pkgs.mpvScripts.sponsorblock;
    thumbnail = pkgs.mpvScripts.thumbnail;
    smart-copy-paste-2 = pkgs.mpvScripts.smart-copy-paste-2;
  };

  plugins =
    lib.mapAttrs' (name: pkg: {
      name = "${config.xdg.configHome}/celluloid/scripts/${name}.lua";
      value.source = "${pkg}/share/mpv/scripts/${name}.lua";
    })
    pluginsPkgs;

  subsync = {
    "${config.xdg.configHome}/celluloid/scripts/autosubsync" = {
      source = "${pkgs.mpvScripts.autosubsync-mpv}/share/mpv/scripts/autosubsync-mpv";
    };
    "${config.xdg.configHome}/celluloid/scripts/sponsorblock_shared" = {
      source = "${pkgs.mpvScripts.sponsorblock}/share/mpv/scripts/sponsorblock_shared";
    };
  };
in {
  home.packages = [pkgs.celluloid];

  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      always-autohide-cursor = true;
      always-use-floating-controls = true;
      last-folder-enable = true;
      mpv-config-enable = true;
      mpv-config-file = "file://${config.xdg.configHome}/mpv/mpv.conf";
      mpv-input-config-enable = true;
      mpv-input-config-file = "file://${config.xdg.configHome}/mpv/input.conf";
    };
  };

  # Merge file and directory symlinks properly
  home.file = plugins // subsync;
}
