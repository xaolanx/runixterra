{
  programs.starship = {
    enable = true;
    settings = {
      character = {
        error_symbol = "[›](bold red)";
        success_symbol = "[›](bold green)";
      };

      git_status = {
        deleted = " ";
        modified = "* ";
        staged = " ";
        stashed = "≡ ";
      };

      nix_shell = {
        heuristic = true;
        symbol = " ";
      };
    };
  };
}
