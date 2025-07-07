{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];

  programs = {
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
      profiles.xaolan = {
        id = 0;
        isDefault = true;
        search = {
          force = true;
          order = [
            "google"
            "Searx"
            "NixOS Packages"
            "NixOS Options"
            "NixOS Wiki"
            "Home Manager Options"
          ];
          default = "google";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nw"];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://mipmip.github.io/home-manager-option-search";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master";
                    }
                  ];
                }
              ];
              icon = "https://avatars.githubusercontent.com/u/33221035";
              updateInterval = 24 * 60 * 60 * 1000; # Update every day.
              definedAliases = ["@hm"];
            };
            "google".metaData.alias = "@g";
          };
        };
        extraConfig = ''
          ${builtins.readFile "${inputs.betterfox}/zen/user.js"}
        '';
      };
    };
  };
}
