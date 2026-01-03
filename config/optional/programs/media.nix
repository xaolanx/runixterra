{pkgs, ...}: {
  config = {
    hj.packages = builtins.attrValues {
      inherit
        (pkgs)
        spotify
        # tidal-hifi
        celluloid
        gthumb
        papers
        audacious
        ;
    };
  };
}
