{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      repl = pkgs.callPackage ./repl {};
    };
  };
}
