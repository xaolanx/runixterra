{
  description = "xaolan's NixOS and Home-Manager flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./pkgs/dev.nix
        ./pre-commit-hooks.nix
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells = {
          default = pkgs.mkShell {
            name = "dots";
            packages = [
              pkgs.alejandra
              pkgs.deadnix
              pkgs.statix
              pkgs.git
              pkgs.nodePackages.prettier
              config.packages.repl
            ];
            DIRENV_LOG_FORMAT = "";
            shellHook = ''
              ${config.pre-commit.installationScript}

              if git rev-parse --git-dir > /dev/null 2>&1; then
                if [ ! -f "$(git rev-parse --git-path hooks/pre-commit)" ]; then
                  echo "[info] Installing pre-commit hook..."
                  pre-commit install
                fi
              fi
            '';
          };
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    systems.url = "github:nix-systems/default-linux";
    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };
  };
}
