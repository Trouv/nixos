{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    enableManpages = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "dracula";
      };

      spellcheck.enable = true;

      lsp = {
        enable = true;
        formatOnSave = true;
      };

      languages.nix = {
        enable = true;
        format.enable = true;
        lsp.enable = true;
      };

      languages.rust = {
        enable = true;
        lsp = {
          enable = true;
          opts = ''
            ["rust-analyzer"] = {
              cargo = {allFeatures = true},
            }
          '';
        };
      };

      languages.yaml = {
        enable = true;
        lsp.enable = true;
      };

      globals = {
        rustfmt_command = "~/.cargo/bin/rustfmt +nightly";
        rustfmt_autosave = 1;
      };

      keymaps = [
        {
          key = "<leader>lge";
          mode = "n";
          silent = true;
          action = ":RustLsp expandMacro<CR>";
        }
      ];

      comments.comment-nvim.enable = true;

      utility.surround.enable = true;

      autocomplete.blink-cmp = {
        enable = true;
        setupOpts.completion.list.selection.preselect = false;
        setupOpts.cmdline.completion = {
          menu.auto_show = true;
          list.selection.preselect = false;
        };
      };

      statusline.lualine.enable = true;
    };
  };
}
