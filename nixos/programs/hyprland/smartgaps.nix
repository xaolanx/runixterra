{ config, pkgs, lib, ... }: let
  inherit (builtins) concatStringsSep;
  inherit (lib.lists) flatten;
  inherit (lib.strings) escapeShellArg;

  gaps_out = 8;
  gaps_in = 4;
  border_size = 2;
  rounding = 5;

  workspaceSelectors = ["w[t1]" "w[tg1]" "f[1]"];

  forEach = f: concatStringsSep "\n" (map f workspaceSelectors);

  toggleSmartGaps = pkgs.writeShellScriptBin "toggleSmartGaps" ''
    hyprctl -j workspacerules | ${lib.getExe pkgs.jaq} -e '
      any(.[]; select(
        .workspaceString == "w[t1]" or
        .workspaceString == "w[tg1]" or
        .workspaceString == "w[f1]"
      ) | (.gapsIn | all(. == 0)) and (.gapsOut | all(. == 0)))
    ' > /dev/null

    if [ $? -eq 0 ]; then
      ${forEach (selector: ''
        hyprctl keyword workspace "${selector}, gapsout:${toString gaps_out}, gapsin:${toString gaps_in}"
        hyprctl keyword windowrulev2 "bordersize ${toString border_size}, floating:0, onworkspace:${selector}"
        hyprctl keyword windowrulev2 "rounding ${toString rounding}, floating:0, onworkspace:${selector}"
      '')}
    else
      ${forEach (selector: ''
        hyprctl keyword workspace "${selector}, gapsout:0, gapsin:0"
        hyprctl keyword windowrulev2 "bordersize 0, floating:0, onworkspace:${selector}"
        hyprctl keyword windowrulev2 "rounding 0, floating:0, onworkspace:${selector}"
      '')}
    fi
  '';
in {
  environment.systemPackages = [
    toggleSmartGaps
  ];
}
