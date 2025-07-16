{lib, ...}: let
  username = "xaolan";
  configDir = ./dots;

  userFiles = lib.pipe (lib.filesystem.listFilesRecursive configDir) [
    (builtins.filter (file: lib.hasSuffix ".nix" file))
    (map (file: let
      imported = import file;
    in
      if builtins.isFunction imported
      then imported {}
      else imported))
    (lib.foldl' lib.recursiveUpdate {})
  ];
in {
  hjem.users.${username}.files = userFiles;
}
