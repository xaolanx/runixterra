<h1 id="header" align="center">
  <img src="assets/nix-snowflake-colors.svg" width="128px" height="128px" />
  <br>
  runixterra
</h1>

My NixOS configurations, using flakes.

# 🛠️ Structure

| Name                | Description                                                    |
| ------------------- | -------------------------------------------------------------- |
| [assets](assets/)   | Resources used throughout the system (images etc.)             |
| [config](config/)   | NixOS configuration                                            |
| [hosts](hosts/)     | Host-specific                                                  |
| [lib](lib/)         | Internal library functions / helpers                           |
| [modules](modules/) | Internal and shared modules, used throughout [config](config/) |
| [parts](parts/)     | Modularized flake outputs, powered by flake-parts              |

My configuration is structured based on the following principles:

1. Hosts should be the main entry points and outputs.
1. Abstractions should be avoided as much as possible.
1. Setting up theming should be as simple as changing one or two options.

The main configuration can be found in [config](config/), which declares most of
my programs and services.

My hosts can then pick and choose the programs and configurations that they need
from the different files, (which can be found in
[hosts/default.nix](hosts/default.nix)).

# 👥 Credits

People / repositories I have copied / learned from:

- [nezia1/flocon](https://github.com/nezia1/flocon) i'm using this as base
  configuration

- [fufexan/dotfiles](https://github.com/fufexan/dotfiles) for the configuration
  structure
- [Lunarnovaa](https://github.com/Lunarnovaa) for her
  [hjem](https://github.com/feel-co/hjem) configuration and functions, that I
  used when switching away from home-manager, and for being a great person.
- [NotAShelf](https://github.com/NotAShelf) for providing a comprehensive
  archive repo, [nyx](https://github.com/NotAShelf/nyx) who helped me transition
  to flake-parts.

Some bits have also been borrowed from within the configuration, and credit has
been given where its due.
