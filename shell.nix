{system ? builtins.currentSystem}: let
  pins = import ./npins;
  pkgs = import pins.nixpkgs {inherit system;};

  pre-commit = (import pins."pre-commit-hooks.nix").run {
    src = ./.;
    hooks = {
      alejandra.enable = true;
      deadnix.enable = true;
      prettier = {
        enable = true;
        excludes = [".js" ".md" ".ts"];
      };
    };
  };
in
  pkgs.mkShell {
    packages = with pkgs; [
      alejandra
      deadnix
      nodePackages.prettier
    ];

    inherit (pre-commit) shellHook;
  }
