{config, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
      "intel-media-sdk-23.2.2"
    ];
  };
}
