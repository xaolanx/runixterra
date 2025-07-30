{
  self,
  inputs,
  withSystem,
  ...
}: let
  mkNixosSystem = {system, ...} @ args:
    withSystem system (
      {
        inputs',
        self',
        pins,
        lib,
        myLib,
        ...
      }:
        lib.nixosSystem {
          specialArgs = {inherit inputs inputs' self self' myLib pins;};
          modules = myLib.resolveAndFilter (args.modules or []);
        }
    );

  base = [
    ../config/base
    ../modules/internal
    inputs.agenix.nixosModules.default
    inputs.disko.nixosModules.default
  ];

  workstation = [
    ../config/optional/core/boot.nix
    ../config/optional/core/fonts.nix
    ../config/optional/core/networking.nix
    ../config/optional/core/security.nix

    ../config/optional/hardware/bluetooth.nix
    ../config/optional/hardware/printing.nix

    ../config/optional/programs/editors
    ../config/optional/programs/terminal
    ../config/optional/programs/mpv
    ../config/optional/programs/browsers
    ../config/optional/programs/comma.nix
    ../config/optional/programs/discord.nix
    ../config/optional/programs/kdeconnect.nix
    ../config/optional/programs/librewolf.nix
    ../config/optional/programs/media.nix
    ../config/optional/programs/misc.nix
    ../config/optional/programs/pcmanfm.nix
    ../config/optional/programs/xdg.nix

    ../config/optional/services/documentation.nix
    ../config/optional/services/flatpak.nix
    ../config/optional/services/keyd.nix
    #../config/optional/services/kmscon.nix
    ../config/optional/services/location.nix
    ../config/optional/services/pipewire.nix
    ../config/optional/services/sddm.nix
    ../config/optional/services/ssh.nix

    ../config/optional/theming
  ];

  wm = [
    ../config/optional/services/brightness.nix

    ../config/optional/programs/walker
    ../config/optional/programs/swaybg.nix
    ../config/optional/programs/wlogout.nix
    ../config/optional/programs/quickshell.nix

    ../config/optional/services/gammastep.nix
    ../config/optional/services/gnome.nix
    ../config/optional/services/greetd.nix
    ../config/optional/services/idle.nix
    ../config/optional/services/logind.nix
    ../config/optional/services/power.nix
  ];

  niri = [
    ../config/optional/programs/niri
    ../config/optional/programs/uwsm.nix
  ];

  hyprland = [
    ../config/optional/programs/hypr
  ];
in {
  flake.nixosConfigurations = {
    ionia = mkNixosSystem {
      system = "x86_64-linux";
      modules =
        base
        ++ workstation
        ++ hyprland
        ++ wm
        ++ [
          ./ionia
          ../config/optional/programs/games.nix
        ];
    };

    yunara = mkNixosSystem {
      system = "x86_64-linux";
      modules =
        base
        ++ workstation
        ++ wm
        ++ niri
        ++ [
          ./yunara
          ../config/optional/programs/games.nix
        ];
    };
  };
}
