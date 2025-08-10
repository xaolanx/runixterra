_: {
  perSystem = {
    pkgs,
    lib,
    self',
    pins,
    ...
  }: let
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
        };
        kvlibadwaita = basePackages.kvlibadwaita.override {
          src = pins.kvlibadwaita;
          theme = "woodland";
        };
        caelestia-shell = basePackages.caelestia-shell.override {
          caelestia-cli = cli;
          quickshell = pkgs.quickshell;
          app2unit = app2unitPkg;
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
