{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;

    homeImports = import "${self}/home/profiles";

    mod = "${self}/system";
    # get the basic config to build on top of
    inherit (import mod) laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    ionia = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./io

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/games.nix"
          "${mod}/programs/gnome.nix"
          #"${mod}/programs/kde"
          "${mod}/programs/uwsm.nix"

          "${mod}/network/spotify.nix"
          "${mod}/network/syncthing.nix"

          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.xaolan.imports = homeImports."xaolan@ionia";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }

          inputs.chaotic.nixosModules.default
          inputs.disko.nixosModules.default
          self.nixosModules.theme
        ];
    };
  };
}
