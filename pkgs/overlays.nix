# overlay.nix
self: super: {
  lib =
    super.lib
    // {
      colors = import ./lib/colors super.lib;
    };

  gnome-shell = super.gnome-shell.overrideAttrs (old: {
    patches =
      (old.patches or [])
      ++ [
        (
          let
            bg = self.config.theme.wallpaper;
          in
            self.pkgs.writeText "gnome-bg.patch" ''
              --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
              +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
              @@ -15,4 +15,6 @@ $_gdm_dialog_width: 23em;
               /* Login Dialog */
               .login-dialog {
                 background-color: $_gdm_bg;
              +  background-image: url('file://${bg}');
              +  background-size: cover;
               }
            ''
        )
      ];
  });

  hyprlock = import ./hyprlock {
    pkgs = super;
    config = self.config;
  };
}
