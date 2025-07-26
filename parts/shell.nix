_: {
  perSystem = {
    config,
    inputs',
    self',
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = [
        inputs'.agenix.packages.default
        pkgs.npins
        pkgs.commitizen
        self'.formatter
      ];

      shellHook = config.pre-commit.installationScript;
    };
  };
}
