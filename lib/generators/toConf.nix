# lib/generators/toconf.nix
{lib}: let
  mkValueString = v:
    if lib.isList v
    then lib.concatStringsSep "," v
    else if lib.isBool v
    then
      if v
      then "yes"
      else "no"
    else toString v;
in {
  toConf = attrs: let
    regular = lib.filterAttrs (k: _: !lib.hasPrefix "__section_" k) attrs;
    sections = lib.filterAttrs (k: _: lib.hasPrefix "__section_" k) attrs;

    baseConfig = lib.generators.toKeyValue {
      mkKeyValue = lib.generators.mkKeyValueDefault {
        inherit mkValueString;
      } "=";
    };
  in
    lib.concatStringsSep "\n" ([
        (baseConfig regular)
      ]
      ++ (lib.mapAttrsToList
        (k: v: "\n[${lib.removePrefix "__section_" k}]\n${baseConfig v}")
        sections));
}
