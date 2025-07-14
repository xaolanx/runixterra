#!/usr/bin/env fish

set old (readlink -f /run/current-system)

begin
  sudo nixos-rebuild switch --file ./default.nix -A ionia
end &| nom

set new (readlink -f /run/current-system)

nvd diff $old $new
