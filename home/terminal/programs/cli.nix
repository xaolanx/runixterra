{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    libnotify
    sshfs

    # utils
    du-dust
    duf
    fd
    file
    jaq
    ripgrep
    ripdrag
  ];

  programs = {
    eza.enable = true;
    fzf = {
      enable = true;
      colors = lib.mkForce {
        bg = "#191724";
        "bg+" = "#26233a";
        fg = "#908caa";
        "fg+" = "#e0def4";
        hl = "#ebbcba";
        "hl+" = "#ebbcba";
        border = "#403d52";
        header = "#31748f";
        gutter = "#191724";
        spinner = "#f6c177";
        info = "#9ccfd8";
        pointer = "#c4a7e7";
        marker = "#eb6f92";
        prompt = "#908caa";
      };
    };
    ssh = {
      enable = true;

      matchBlocks."cloudut" = {
        hostname = "10.20.7.115";
        user = "cloud7115";
        identityFile = "${config.home.homeDirectory}/.ssh/cloud7115_id_ed25519";
      };
    };
  };
}
