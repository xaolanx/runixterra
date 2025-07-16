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
    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    ionia = nixosSystem {
      inherit specialArgs;
      modules =  [
        ./io
        mod

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
