_: {
  perSystem = {
    config,
    self',
    pkgs,
    pins,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = [
        (pkgs.callPackage (pins.agenix + "/pkgs/agenix.nix") {})
        pkgs.npins
        self'.formatter
      ];

      shellHook = config.pre-commit.installationScript;
    };
  };
}
