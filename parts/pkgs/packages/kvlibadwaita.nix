# █▄▀ █░█ █░░ █ █▄▄ ▄▀█ █▀▄ █░█░█ ▄▀█ █ ▀█▀ ▄▀█ ▀
# █░█ ▀▄▀ █▄▄ █ █▄█ █▀█ █▄▀ ▀▄▀▄▀ █▀█ █ ░█░ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# Taken from github:MOIS3Y/kvlibadwaita
{
  stdenvNoCC,
  lib,
  python3,
  theme ? "adwaita",
  src,
}: let
  pname = "kvlibadwaita";
in
  with lib;
    checkListOfEnum "${pname}: theme name" [
      # Default:
      "adwaita"
      # Expected second argument - base16-scheme-path to base16.json
      "custom"
      # Gradience presets:
      "ashes"
      "aquarium"
      "ayu_dark"
      "ayu_light"
      "bearded_arc"
      "blossom_light"
      "catppuccin_frappe"
      "catppuccin_latte"
      "catppuccin_macchiato"
      "catppuccin_mocha"
      "decay"
      "dracula"
      "everblush"
      "everforest_dark"
      "everforest_light"
      "falcon"
      "gruvbox_dark"
      "gruvbox_light"
      "kanagawa"
      "melange"
      "monochrome"
      "monokai"
      "mountain"
      "nord"
      "onedark"
      "onelight"
      "rosepine"
      "rosepine_dawn"
      "rosepine_moon"
      "solarized"
      "sweetpastel"
      "rxyhn"
      "tokyodark"
      "tokyonight"
      "yoru"
    ] [theme]
    stdenvNoCC.mkDerivation rec {
      inherit pname;
      inherit src;
      version = "2.0";

      outputs = ["out"];

      buildInputs = [python3];

      postPatch = ''
        patchShebangs kvctl.sh

        substituteInPlace kvctl.sh \
          --replace '$HOME/.config/Kvantum' $out/share/Kvantum
      '';

      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/Kvantum
        ./kvctl.sh --no-ask --install ${theme}
        runHook postInstall
      '';

      meta = {
        description = ''
          KvLibadwaita theme for Kvantum which repeats
          the Libadwaita design for your QT applications
          The gradience feature provides the ability
          to override the theme color scheme.
          35 presets from popular themes in
          base16 format are available to choose from
          If your favorite color scheme is not in the list,
          you can pass the path to the base16.json file
          with your favorite theme in base16 format to the builder
        '';
        homepage = "https://github.com/GabePoel/KvLibadwaita";
        license = lib.licenses.gpl3;
        maintainers = with maintainers; [MOIS3Y];
      };
    }
