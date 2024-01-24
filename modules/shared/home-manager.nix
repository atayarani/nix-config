{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "Ali Tayarani";
  user = "ali";
  email = "619512+ChronoSerrano@users.noreply.github.com";
in {
  git = {
    enable = true;
    diff-so-fancy = {enable = true;};
    lfs = {enable = true;};
    userName = "ChronoSerrano";
    userEmail = "619512+ChronoSerrano@users.noreply.github.com";
    ignores = [
    ];
    extraConfig = {
      pull = {rebase = true;};
      init = {defaultBranch = "main";};
      push = {default = "current";};
      fetch = {
        prune = true;
        pruneTags = true;
      };
      rebase = {autostash = true;};
      color = {ui = true;};
    };

    aliases = {track = "!f() { git branch --set-upstream-to=origin/\"$1\" \"$1\"; }; f";};
  };

  nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    plugins = {
      which-key.enable = true;
      lualine.enable = true;
      telescope = {
        enable = true;
        extensions = {
          file_browser = {
            enable = true;
            hidden = true;
          };
          fzy-native.enable = true;
          project-nvim.enable = true;
          frecency.enable = true;
        };
      };
      project-nvim.enable = true;
      treesitter.enable = true;
      lsp = {
        enable = true;
        servers = {
          ruff-lsp.enable = true;
          nixd.enable = true;
        };
      };
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
        ];
      };
    };
  };
  # neovim = {
  # enable = true;
  #         viAlias = true;
  #         vimAlias = true;
  #         vimdiffAlias = true;
  #         defaultEditor = true;
  # };
  # zsh = {
  # enable = true;
  #       enableAutosuggestions = true;
  #       enableCompletion = true;
  #       syntaxHighlighting = { enable = true; };
  #       zsh-abbr = { enable = true; };
  #       dotDir = ".config/zsh";
  #       zplug = { enable = true;
  #       plugins = [
  #       {
  #           name = "plugins/git";
  #           tags = [from:oh-my-zsh];
  #         }
  # 	];
  # 	};
  # };
}
