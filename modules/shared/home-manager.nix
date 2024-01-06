{ config, pkgs, lib, ... }:

let name = "Ali Tayarani";
    user = "ali";
    email = "619512+ChronoSerrano@users.noreply.github.com"; in
{
git = {
 enable = true;
     userName = "ChronoSerrano";
    userEmail = "619512+ChronoSerrano@users.noreply.github.com";
};
neovim = {
enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        defaultEditor = true;
};
zsh = {
enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = { enable = true; };
      zsh-abbr = { enable = true; };
      dotDir = ".config/zsh";
      zplug = { enable = true;
      plugins = [
      {
          name = "plugins/git";
          tags = [from:oh-my-zsh];
        }
	];
	};
};
}
