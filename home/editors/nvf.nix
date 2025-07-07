{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        diagnostics.enable = true;
        options = {
          ignorecase = true;
          smartcase = true;
          autoindent = true;
          linebreak = true;
          undofile = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
          lightbulb = {
            enable = true;
            autocmd.enable = true;
          };
          lspconfig.enable = true;
          lspkind.enable = true;
          null-ls.enable = true;
          lspsaga.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;
          nix.lsp.server = "nixd";
          nix.format = {
            enable = true;
            type = "alejandra";
          };

          clang.enable = true;
          zig.enable = true;
          markdown.enable = true;
          html.enable = true;
          lua.enable = true;
          python.enable = true;
        };
        terminal.toggleterm = {
          enable = true;
          lazygit = {
            enable = true;
            mappings.open = "<leader>lg";
          };
        };
        # enableLuaLoader = true;
        statusline.lualine.enable = true;
        autocomplete = {
          blink-cmp.enable = true;
          blink-cmp.setupOpts.signature.enabled = true;
        };
        autopairs.nvim-autopairs.enable = true;
        telescope.enable = true;
        git = {
          enable = true;
          git-conflict.enable = true;
        };
        preventJunkFiles = true;
        undoFile.enable = true;
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };
        notes = {
          todo-comments.enable = true;
        };
        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };
        theme = {
          enable = true;
          # base16-colors = config.stylix.base16Scheme;
          name = lib.mkDefault "rose-pine";
          style = "moon";
        };
        utility = {
          icon-picker.enable = true;
          diffview-nvim.enable = true;
          motion.leap.enable = true;
        };
        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          fastaction.enable = true;
        };
        mini = {
          align.enable = true;
          pairs.enable = true;
          basics.enable = true;
          surround.enable = true;
          notify.enable = true;
          icons.enable = true;
        };
        snippets.luasnip.enable = true;
        spellcheck.enable = true;
        tabline.nvimBufferline.enable = true;
        comments.comment-nvim.enable = true;
      };
    };
  };
}
