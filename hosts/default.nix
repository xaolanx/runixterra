{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    systemModule = import "${self}/system";
    specialArgs = {
      inherit inputs self;
    };
  in {
    ionia = nixosSystem {
      inherit specialArgs;

      modules = [
        systemModule
        ./ionia

        inputs.chaotic.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.hjem.nixosModules.default
        self.nixosModules.theme
      ];
    };
  };
}
