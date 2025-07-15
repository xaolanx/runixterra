{sources, ...}: {
  ".config/fish/config.fish".source = ./config.fish;
  ".config/fish/themes".source = sources.fish + "/themes";
}
