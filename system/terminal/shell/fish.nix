# stolen from Rexcrazy804
{pkgs, ...}: {
  programs.fish = {
    enable = true;
    useBabelfish = true;

    shellAbbrs = {
      # nix stuff
      ns = "nix shell nixpkgs#";
      nr = "nix run nixpkgs#";
      "nuf --set-cursor" = "env NIXPKGS_ALLOW_UNFREE=1 nix % --impure";

      # git stuff
      gaa = "git add --all";
      ga = "git add";
      gc = "git commit";
      gcm = "git commit -m";
      gca = "git commit --amend";
      gcp = "git cherry-pick";
      grs = "git restore --staged";
      grsa = "git restore --staged .";
      gr = "git restore";
      gra = "git restore .";
      gs = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      gdh = "git diff HEAD~1";
      glg = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      gl = "git log";

      # systemctl
      sy = "systemctl";
      sya = "systemctl start";
      syo = "systemctl stop";
      # systemctl user
      su = "systemctl --user";
      sua = "systemctl --user start";
      suo = "systemctl --user stop";

      # misc
      qsp = "qs --log-rules 'quickshell.dbus.properties.warning = false' -p .";
      lse = "eza --icons --group-directories-first -1";
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first -1";
    };

    shellInit = ''
      # Rosé Pine fish theme
      set -g fish_color_normal e0def4
      set -g fish_color_command c4a7e7
      set -g fish_color_keyword 9ccfd8
      set -g fish_color_quote f6c177
      set -g fish_color_redirection 31748f
      set -g fish_color_end 908caa
      set -g fish_color_error eb6f92
      set -g fish_color_param ebbcba
      set -g fish_color_comment 908caa
      set -g fish_color_selection --reverse
      set -g fish_color_operator e0def4
      set -g fish_color_escape 31748f
      set -g fish_color_autosuggestion 908caa
      set -g fish_color_cwd ebbcba
      set -g fish_color_user f6c177
      set -g fish_color_host 9ccfd8
      set -g fish_color_host_remote c4a7e7
      set -g fish_color_cancel e0def4
      set -g fish_color_search_match --background=191724

      # Pager colors
      set -g fish_pager_color_progress ebbcba
      set -g fish_pager_color_background --background=1f1d2e
      set -g fish_pager_color_prefix 9ccfd8
      set -g fish_pager_color_completion 908caa
      set -g fish_pager_color_description 908caa
      set -g fish_pager_color_selected_background --background=26233a
      set -g fish_pager_color_selected_prefix 9ccfd8
      set -g fish_pager_color_selected_completion e0def4
      set -g fish_pager_color_selected_description e0def4

      # Optional custom color names (for scripts)
      set -g fish_color_subtle 908caa
      set -g fish_color_text e0def4
      set -g fish_color_love eb6f92
      set -g fish_color_gold f6c177
      set -g fish_color_rose ebbcba
      set -g fish_color_pine 31748f
      set -g fish_color_foam 9ccfd8
      set -g fish_color_iris c4a7e7
    '';

    interactiveShellInit = let
      rosepine-fzf = [
        "fg:#908caa"
        "bg:-1"
        "hl:#ebbcba"
        "fg+:#e0def4"
        "bg+:#26233a"
        "hl+:#ebbcba"
        "border:#403d52"
        "header:#31748f"
        "gutter:#191724"
        "spinner:#f6c177"
        "info:#9ccfd8"
        "pointer:#c4a7e7"
        "marker:#eb6f92"
        "prompt:#908caa"
      ];
      fzf-options = builtins.concatStringsSep " " (builtins.map (option: "--color=" + option) rosepine-fzf);
    in ''
      set sponge_purge_only_on_exit true
      set fish_greeting
      set fish_cursor_insert line blink
      set -Ux FZF_DEFAULT_OPTS ${fzf-options}
      fish_vi_key_bindings

      function fish_user_key_bindings
        bind --mode insert alt-c 'cdi; commandline -f repaint'
        bind --mode insert alt-f 'fzf-file-widget'
      end

      # hydro (prompt) stuff
      set -g hydro_symbol_start
      set -U hydro_symbol_git_dirty "*"
      set -U fish_prompt_pwd_dir_length 0
      function fish_mode_prompt; end
      function update_nshell_indicator --on-variable IN_NIX_SHELL
        if test -n "$IN_NIX_SHELL"
          set -g hydro_symbol_start "impure "
        else
          set -g hydro_symbol_start
        end
      end
      update_nshell_indicator

      function store_path -a package_name
        which $package_name 2> /dev/null | path resolve | read -l package_path
        if test -n "$package_path"
          echo (path dirname $package_path | path dirname)
        end
      end
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--cmd cd"];
  };

  programs.command-not-found.enable = false;
  programs.fzf.keybindings = true;

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.sponge
    fishPlugins.hydro
    fishPlugins.z
    fishPlugins.pure
    fishPlugins.humantime-fish
    fishPlugins.fzf
    fishPlugins.bass
    eza
    fish-lsp
  ];
}
