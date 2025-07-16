{lib, ...}: let
  username = "xaolan";
  configDir = ./dots;

  nixFiles =
    builtins.filter (file: lib.hasSuffix ".nix" (toString file))
    (lib.filesystem.listFilesRecursive configDir);

  # Import and apply files if they are functions, or use as-is if they are sets
  userFiles =
    lib.foldl'
    lib.recursiveUpdate
    {}
    (map (
        file: let
          imported = import file;
        in
          if builtins.isFunction imported
          then imported {inherit sources;} # pass specialArgs like `sources`
          else imported
      )
      nixFiles);
in {
  hjem.users.${username}.files = userFiles;
}
