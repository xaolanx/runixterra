{ self, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
        "intel-media-sdk-23.2.2"
      ];
    };

    overlays = [
      (final: prev: {
        lib = prev.lib // {
          colors = import "${self}/lib/colors" prev.lib;
        };
      })

      (final: prev: {
        intel-media-sdk = prev.intel-media-sdk.overrideAttrs (old: {
          cmakeFlags = (old.cmakeFlags or []) ++ [
            "-DCMAKE_CXX_STANDARD=17"
          ];

          NIX_CFLAGS_COMPILE =
            (old.NIX_CFLAGS_COMPILE or "") + " -std=c++17";
        });
      })
    ];
  };
}
