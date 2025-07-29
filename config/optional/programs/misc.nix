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
          ;

        inherit
          (pkgs)
          cinny-desktop
          devenv
          entr
          fastfetch
          fzf
          obsidian
          playerctl
          proton-pass
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
