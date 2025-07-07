{
  config,
  pkgs,
  inputs,
  ...
}: let
  ff-ultima = pkgs.fetchFromGitHub {
    owner = "soulhotel";
    repo = "FF-ULTIMA";
    rev = "5a81c9e";
    sha256 = "sha256-XpPE92p6isit2ye1Ct2W9U/hwk4kym8Jo9E0b8P6Z84=";
  };
in {
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-beta;
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

        settings = {
          "apz.overscroll.enabled" = true;
          "browser.aboutConfig.showWarning" = false;
          "general.autoScroll" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # Ultima settings
          # Theme
          "user.theme.adaptive" = true;
          "user.theme.dark.a" = true;
          "user.theme.dark.catppuccin-mocha" = true;
          "user.theme.light.a" = true;
          "user.theme.light.gruvbox" = true;
          "user.theme.sideberry" = true;
          "user.theme.wallpaper.catppuccin-mocha" = true;
          "user.theme.wallpaper.gruvbox.light" = true;
          # Overrdes
          "ultima.disable.altavs.button" = true;
          "ultima.disable.contextmenu.collapsing" = true;
          "ultima.navbar.theme.extensonspanel" = true;
          "ultima.navbar.windowcontrols.whiteout" = true;
          "ultima.sidebar.hidden" = true;
          "ultima.sidebar.hide.header" = true;
          "ultima.sidebery.expandon.inactive.windows" = true;
          "ultima.spacing.compact" = true;
          "ultima.spacing.compact.contextmenu" = true;
          "ultima.spacing.tabs" = true;
          "ultima.tabs.autohide" = true;
          "ultima.tabs.belowURLbar" = true;
          "ultima.tabs.disable.update.dot" = true;
          "ultima.tabs.pinnedtabs.style1" = true;
          "ultima.tabs.tabContainer.3" = true;
          "ultima.tabs.tabgroups.background.2" = true;
          "ultima.tabs.tabgroups.label.2" = true;
          "ultima.tabs.vertical.hide.in.screenedge" = true;
          "ultima.tabs.width.small" = true;
          "ultima.theme.color.swap" = true;
          "ultima.theme.extensions" = true;
          "ultima.theme.icons" = true;
          "ultima.theme.menubar" = true;
          "ultma.urlbar.animate.open" = true;
          "ultma.urlbar.animate.options" = true;
          "ultma.urlbar.centered" = true;
          "ultma.urlbar.float" = true;
          "ultma.urlbar.suggestions" = true;
          "ultma.urlbar.transparent" = true;
          "ultima.xstyle.containertabs.iii" = true;
          "ultima.xstyle.highlight.aboutconfig" = true;
          "ultima.xstyle.newtab.rounded" = true;
          "ultima.xstyle.pinnedtabs.i" = true;
          "ultima.xstyle.private" = true;
          "ultima.xstyle.sidebar.themeing" = true;
          "ultima.xstyle.tabgroups.i" = true;
          "ultima.xstyle.urlbar" = true;
        };
        userChrome = builtins.readFile (ff-ultima + "/userChrome.css");
        userContent = builtins.readFile (ff-ultima + "/userContent.css");
        extraConfig = ''
          ${builtins.readFile "${inputs.betterfox}/Fastfox.js"}
          ${builtins.readFile "${inputs.betterfox}/Peskyfox.js"}
          ${builtins.readFile "${inputs.betterfox}/Securefox.js"}
          ${builtins.readFile "${inputs.betterfox}/Smoothfox.js"}
        '';
      };
    };
  };

  home.file.".mozilla/firefox/${config.programs.firefox.profiles.xaolan.path}/chrome/theme" = {
    source = "${ff-ultima}/theme";
    recursive = true;
  };
}
