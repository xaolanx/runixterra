{
  pkgs,
  self',
  ...
}: {
  config = {
    hj = {
      packages = builtins.attrValues {
        inherit
          (self'.packages)
          app2unit
          gpurecording
          helium-browser
          ;

        inherit
          (pkgs)
          devenv
          entr
          fastfetch
          fzf
          obsidian
          playerctl
          qalculate-gtk
          resources
          simple-scan
          wl-clipboard
          cliphist
          telegram-desktop
          ;
      };
    };
  };
}
