{
  lib,
  callPackage,
}:
lib.makeExtensible (_final: {
  wallcrop = callPackage ./wallcrop.nix {};
  cowask = callPackage ./cowask.nix {};
  gpurecording = callPackage ./gpurecording.nix {};
  kde-send = callPackage ./kde-send.nix {};
  writeAwk = callPackage ./writeAwkScript.nix {};
  writeAwkBin = name: final.writeAwkScript "/bin/${name}";
  npins-show = callPackage ./npins-show.nix {inherit (final) writeAwk;};
})
