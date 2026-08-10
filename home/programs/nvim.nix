{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    enableManpages = true;

    settings.vim = {
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
        lsp.enable = true;
      };

      languages.yaml = {
        enable = true;
        lsp.enable = true;
      };

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

      filetree.neo-tree.enable = true;
    };
  };
}
