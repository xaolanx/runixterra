_: {
  perSystem = {
    pkgs,
    lib,
    self',
    pins,
    ...
  }: let
    app2unitPkg = self'.packages.app2unit;

    basePackages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };

    cliAndShell = lib.fix (self: {
      caelestia-cli = pkgs.callPackage (pins.caelestia-cli + "/default.nix") {
        rev = pins.caelestia-cli.rev or "dirty";
        caelestia-shell = pkgs.runCommand "dummy-shell" {} "mkdir -p $out";
        app2unit = app2unitPkg;
        withShell = false;
      };

      caelestia-shell = pkgs.callPackage (pins.caelestia-shell + "/nix/default.nix") {
        rev = pins.caelestia-shell.rev or "dirty";
        caelestia-cli = self.caelestia-cli;
        quickshell = pkgs.quickshell;
        app2unit = app2unitPkg;
        withCli = true;
      };
    });
  in {
    packages =
      basePackages
      // {
        noctalia = basePackages.noctalia.override {
          configPath = ./../../assets/noctalia;
        };

        kvlibadwaita = basePackages.kvlibadwaita.override {
          src = pins.kvlibadwaita;
          theme = "woodland";
        };

        inherit (cliAndShell) caelestia-shell caelestia-cli;
      };
  };
}
