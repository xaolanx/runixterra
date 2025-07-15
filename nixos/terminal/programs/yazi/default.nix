{pkgs, ...}: {
  programs.yazi = {
    enable = true;

    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      smart-filter = pkgs.yaziPlugins.smart-filter;
      diff = pkgs.yaziPlugins.diff;
      chmod = pkgs.yaziPlugins.chmod;
      mount = pkgs.yaziPlugins.mount;

      glow = pkgs.yaziPlugins.glow;

      hexyl = pkgs.fetchFromGitHub {
        owner = "Reledia";
        repo = "hexyl.yazi";
        rev = "main";
        hash = "sha256-ly/cLKl2y3npoT2nX8ioGOFcRXI4UXbD9Es/5veUhOU=";
      };
    };
  };
}
