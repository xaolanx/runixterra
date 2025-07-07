{
  pkgs,
  lib,
  config,
  ...
}: let
  isFishEnabled = config.programs.fish.enable;
  fnDir = ./functions;
in {
  programs.fish = {
    enable = true;
    package = pkgs.fish;
    functions = {
      fzf-rosepine = lib.fileContents (fnDir + "/fzf_rosepine.fish");
    };

    binds = {
      "alt-shift-b".command = "fish_commandline_append bat";
      "alt-s".erase = true;
      "alt-s".operate = "preset";
    };

    plugins = lib.optionals isFishEnabled [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      {
        name = "humantime-fish";
        src = pkgs.fishPlugins.humantime-fish.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf.src;
      }
      {
        name = "fish-bd";
        src = pkgs.fishPlugins.fish-bd.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }

      # Custom plugins from GitHub
      {
        name = "bak";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-bak";
          rev = "master";
          sha256 = "sha256-5BeSsy2JFkaKfXOtscJZVoaSK4FO8H6MXuV43uKd4TI=";
        };
      }
      {
        name = "msg";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-msg";
          rev = "master";
          sha256 = "sha256-pYtwbsXmn+4Mde56z/JBVnzFVUof2AZzZCD21byi+Sc=";
        };
      }
      {
        name = "cd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-cd";
          rev = "master";
          sha256 = "sha256-AyzsZtulusGbRQUCgKJtw5NzK5rAHsYGG1Ye/saK9+o=";
        };
      }
    ];

    interactiveShellInit = ''
      # === Environment Variables ===
      if not contains -- $HOME/.local/bin $PATH
        set -gx PATH $HOME/.local/bin $HOME/bin $PATH
      end

      # === Custom Fish Greeting ===
      function fish_greeting
        set -l datetime (date "+%H %A, %B %d %H:%M")
        set -l hour (string split ' ' $datetime)[1]
        set -l current_datetime (string join ' ' (string split ' ' $datetime)[2..])

        set -l greeting
        if test $hour -ge 5 -a $hour -lt 12
          set greeting "Good morning"
        else if test $hour -ge 12 -a $hour -lt 18
          set greeting "Good afternoon"
        else
          set greeting "Good evening"
        end

        set -l c_greeting (set_color --bold yellow)
        set -l c_user (set_color cyan)
        set -l c_date (set_color green)
        set -l c_reset (set_color normal)
        set -l fish_symbol (set_color brblue)"<><"$c_reset

        echo "$c_greeting$greeting,$c_reset $c_user$USER$c_reset! Today is $c_date$current_datetime$c_reset $fish_symbol"
      end

      set -g fish_greeting fish_greeting

      function fish_user_key_bindings
        bind --erase --preset \es
        bind \e\e 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
      end

      function fish_prompt --description 'Write out the prompt'
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status
        set -l normal (set_color normal)
        set -q fish_color_status
        or set -g fish_color_status red

        set -l color_cwd $fish_color_cwd
        set -l suffix '>'
        if functions -q fish_is_root_user; and fish_is_root_user
          if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
          end
          set suffix '#'
        end

        set -l bold_flag --bold
        set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
        if test $__fish_prompt_status_generation = $status_generation
          set bold_flag
        end
        set __fish_prompt_status_generation $status_generation
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color $bold_flag $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
      end
    '';

    shellAliases = {
      warpstat = "curl https://www.cloudflare.com/cdn-cgi/trace/";
    };
  };
}
