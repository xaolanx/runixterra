{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    systemModule = import "${self}/system";
    homeModule = import "${self}/home";
    specialArgs = {
      inherit inputs self;
    };
  in {
    ionia = nixosSystem {
      inherit specialArgs;

      modules = [
        systemModule
        homeModule
        ./ionia

        inputs.chaotic.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.hjem.nixosModules.default
        self.nixosModules.theme
      ];
    };
  };
}
