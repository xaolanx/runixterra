{ pkgs, lib, config, sources, ... }: let
  username = "xaolan";
  configDir = ./dots;

  # Filter for .nix files only
  nixFiles = builtins.filter (file: lib.hasSuffix ".nix" (toString file)) 
    (lib.filesystem.listFilesRecursive configDir);

  # Import and merge all .nix files
  userFiles = lib.foldl'
    lib.recursiveUpdate
    {}
    (map import nixFiles);

in {
  runixterra.data.users = [username];

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
    ];
  };

  hjem.users.${username}.files = userFiles;
}
