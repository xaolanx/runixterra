{
  inputs,
  pkgs,
  config,
  pins,
  lib,
  ...
}: let
  inherit (config.local.vars.system) username;
  inherit (pkgs) callPackage;
in {
  age.secrets.nix-access-tokens-github = {
    file = ../../secrets/nix-access-tokens-github.age;
    # needs to be user readable
    mode = "0500";
    owner = username;
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lixPackageSets.latest.lix;
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

    extraOptions = ''
      !include ${config.age.secrets.nix-access-tokens-github.path}
    '';
  };

  nixpkgs.overlays = [
    (_self: super: {
      intel-media-sdk = super.intel-media-sdk.overrideAttrs (old: {
        cmakeFlags = old.cmakeFlags ++ ["-DCMAKE_CXX_STANDARD=17"];
        NIX_CFLAGS_COMPILE = "-std=c++17";
      });

      quickshell = super.callPackage pins.quickshell {};
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
