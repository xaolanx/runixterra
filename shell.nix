{
  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = pkgs.lib;
    myLib = lib.filesystem.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage newScope;
      directory = ./lib;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [pkgs.coreutils];
      shellHook = ''
        echo "Test config:"
        echo '${myLib.generators.toConf {
          port = 1234;
          __section_db = {
            user = "admin";
            pass = "secret";
          };
        }}'
      '';
    };
  };
}
