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
        excludes = [".js" ".md" ".ts"]; # adjust as needed
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

    shellHook = ''
      ${pre-commit.shellHook}
      if [ ! -f .git/hooks/pre-commit ]; then
        echo "Installing pre-commit hook..."
        pre-commit install
      fi
    '';
  }
