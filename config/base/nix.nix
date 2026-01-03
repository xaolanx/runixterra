{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lix;
    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      accept-flake-config = true;
      warn-dirty = false;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      keep-derivations = true;
      keep-outputs = true;
      trusted-users = ["root" "@wheel"];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.overlays = [
    (_self: super: {
      intel-media-sdk = super.intel-media-sdk.overrideAttrs (old: {
        cmakeFlags = old.cmakeFlags ++ ["-DCMAKE_CXX_STANDARD=17"];
        NIX_CFLAGS_COMPILE = "-std=c++17";
      });

      npins = super.npins.overrideAttrs (_: {
        version = "0.3.1";
        src = super.fetchFromGitHub {
          owner = "andir";
          repo = "npins";
          tag = "0.3.1";
          sha256 = "sha256-PPk9Ve1pM3X7NfGeGb8Jiq4YDEwAjErP4xzGwLaakTU=";
        };
      });
    })
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "cinny-4.2.3"
        "cinny-unwrapped-4.2.3"
        "segger-jlink-qt4-810"
        "olm-3.2.16"
        "libsoup-2.74.3"
        "intel-media-sdk-23.2.2"
      ];
      segger-jlink.acceptLicense = true;
    };
  };
  programs.nix-ld.enable = true;
}
