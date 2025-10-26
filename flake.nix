{
  description = "xaolan's nixos configuration";

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./hosts
        ./parts
      ];
      systems = ["x86_64-linux"];
    };
  inputs = {
    # so we can .follow it
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nixos-hardware.url = "github:NixOS/nixos-hardware";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # sorted alphabetically

    base16.url = "github:SenchoPens/base16.nix";

    # hjem
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # FIXME: back to upstream when https://github.com/snugnug/hjem-rum/pull/140 gets merged
    hjem-rum = {
      url = "github:snugnug/hjem-rum/pull/140/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprwm
    hyprland.url = "github:hyprwm/hyprland";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };

    # dependency pinning to prevent duplicate versions
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };
  nixConfig = {
    extra-substituters = [
      # use nixos cache first
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://yunara.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "yunara.cachix.org-1:UIO2UthUkUv45xwICfmHrPPeeCHioVrAJZAx+jQjV0E="
    ];
  };
}
