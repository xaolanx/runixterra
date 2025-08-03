_: {
  perSystem = {
    pkgs,
    lib,
    inputs',
    self',
    pins,
    ...
  }: let
    quickshellPkg = inputs'.quickshell.packages.default;
    cli = self'.packages.caelestia-cli;
    shell = self'.packages.caelestia-shell;
    app2unitPkg = self'.packages.app2unit;

    basePackages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };
  in {
    packages =
      basePackages
      // {
        # kurukurubar = basePackages.kurukurubar.override {
        #   configPath = ./../../assets/kurukurubar;
        #   quickshell = quickshellPkg;
        # };

        noctalia = basePackages.noctalia.override {
          configPath = ./../../assets/noctalia;
          quickshell = quickshellPkg;
        };
        kvlibadwaita = basePackages.kvlibadwaita.override {
          src = pins.kvlibadwaita;
          theme = "woodland";
        };
        caelestia-shell = basePackages.caelestia-shell.override {
          caelestia-cli = cli;
          app2unit = app2unitPkg;
          quickshell = quickshellPkg;
          withCli = false;
          src = pins.caelestia-shell;
        };
        caelestia-cli = basePackages.caelestia-cli.override {
          caelestia-shell = shell;
          app2unit = app2unitPkg;
          withShell = true;
          src = pins.caelestia-cli;
        };
      };
  };
}
