{sources, ...}: {
  imports = [
    ./activation.nix
    ./substituters.nix
    ./nh.nix
  ];
  nixpkgs = {
    config.permittedInsecurePackages = [
      "intel-media-sdk-23.2.2"
    ];
    config.allowUnfree = true;
    flake.source = sources.nixpkgs;
  };

  nix = {
    channel.enable = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "@wheel"];
      keep-derivations = true;
      keep-outputs = true;
      builders-use-substitutes = true;
    };
  };
  documentation.man = {
    man-db.enable = false;
    man-db.manualPages = false;
  };
}
