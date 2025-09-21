_: {
  perSystem = {
    pkgs,
    lib,
    self',
    inputs',
    pins,
    ...
  }: let
    app2unitPkg = self'.packages.app2unit;

    basePackages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };

    cliAndShell = lib.fix (self: {
      caelestia-shell = pkgs.callPackage (pins.caelestia-shell + "/nix/default.nix") {
        rev = pins.caelestia-shell.rev or "unstable";
        caelestia-cli = self.caelestia-cli;
        quickshell = inputs'.quickshell.packages.default;
        app2unit = app2unitPkg;
        withCli = true;
      };

      caelestia-cli = pkgs.callPackage (pins.caelestia-cli + "/default.nix") {
        rev = pins.caelestia-cli.rev or "unstable";
        caelestia-shell = self.caelestia-shell;
        app2unit = app2unitPkg;
        withShell = false;
      };
    });
  in {
    packages =
      basePackages
      // {
        kvlibadwaita = basePackages.kvlibadwaita.override {
          src = pins.kvlibadwaita;
          theme = "woodland";
        };

        inherit (cliAndShell) caelestia-shell caelestia-cli;
      };
  };
}
