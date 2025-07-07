{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      # instant repl with automatic flake loading
      repl = pkgs.callPackage ./repl {};

      bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor {};

      wl-ocr = pkgs.callPackage ./wl-ocr {};

      fdm = pkgs.callPackage ./fdm {};

      # gruvbox-plus = pkgs.callPackage ./gruvbox {};

      # aporetic-nerd-patch = pkgs.callPackage ./aporetic-nerd {};
    };
  };
}
