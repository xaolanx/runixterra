{
  description = "xaolan's NixOS and Home-Manager flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./hosts
        ./lib
        ./modules
        ./pkgs
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
              pkgs.git
              pkgs.nodePackages.prettier
              config.packages.repl
            ];
            DIRENV_LOG_FORMAT = "";
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };

          tidal-ng = import ./shells/tidal-ng.nix {inherit pkgs;};
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    systems.url = "git+https://github.com/nix-systems/default-linux?shallow=1";
    flake-compat.url = "git+https://github.com/edolstra/flake-compat?shallow=1";

    flake-utils = {
      url = "git+https://github.com/numtide/flake-utils?shallow=1";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "git+https://github.com/hercules-ci/flake-parts?shallow=1";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";

    anyrun.url = "git+https://github.com/anyrun-org/anyrun?shallow=1";

    aporetic-nerd-patch.url = "git+https://github.com/xaolanx/aporetic-nerd-patch?shallow=1";

    betterfox = {
      url = "git+https://github.com/yokoffing/Betterfox?shallow=1";
      flake = false;
    };

    catppuccin.url = "git+https://github.com/catppuccin/nix?shallow=1";

    chaotic.url = "git+https://github.com/chaotic-cx/nyx?shallow=1&ref=nyxpkgs-unstable";

    colloid-icon.url = "git+https://github.com/xaolanx/Colloid-icon-theme?shallow=1";

    disko = {
      url = "git+https://github.com/nix-community/disko?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    erosanix = {
      url = "git+https://github.com/emmanuelrosa/erosanix?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # helix.url = "git+https://github.com/helix-editor/helix?shallow=1";

    hm = {
      url = "git+https://github.com/nix-community/home-manager?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/hyprland?shallow=1";

    hypridle = {
      url = "git+https://github.com/hyprwm/hypridle?shallow=1";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "git+https://github.com/hyprwm/contrib?shallow=1";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "git+https://github.com/hyprwm/hyprland-plugins?shallow=1";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "git+https://github.com/hyprwm/hyprlock?shallow=1";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprpaper = {
      url = "git+https://github.com/hyprwm/hyprpaper?shallow=1";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    niri = {
      url = "git+https://github.com/sodiboo/niri-flake?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-yazi-flavors.url = "git+https://github.com/aguirre-matteo/nix-yazi-flavors?shallow=1";

    nix-index-db = {
      url = "git+https://github.com/Mic92/nix-index-database?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "git+https://github.com/fufexan/nix-gaming?shallow=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    nur = {
      url = "git+https://github.com/nix-community/NUR?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "git+https://github.com/notashelf/nvf?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plasma-manager = {
    #   url = "git+https://github.com/nix-community/plasma-manager?shallow=1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "hm";
    # };

    pre-commit-hooks = {
      url = "git+https://github.com/cachix/pre-commit-hooks.nix?shallow=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    yazi.url = "git+https://github.com/sxyazi/yazi?shallow=1";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "git+https://github.com/danth/stylix?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tailray = {
      url = "git+https://github.com/NotAShelf/tailray?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tidaluna = {
      url = "git+https://github.com/Inrixia/TidaLuna?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "git+https://github.com/0xc000022070/zen-browser-flake?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
