_: {
  perSystem = {
    pkgs,
    lib,
    inputs',
    ...
  }: let
    quickshellPkg = inputs'.quickshell.packages.default;

    basePackages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };
  in {
    packages =
      basePackages
      // {
        kurukurubar = basePackages.kurukurubar.override {
          configPath = ./../../assets/kurukurubar;
          quickshell = quickshellPkg;
        };

        noctalia = basePackages.noctalia.override {
          configPath = ./../../assets/noctalia;
          quickshell = quickshellPkg;
        };
      };
  };
}
