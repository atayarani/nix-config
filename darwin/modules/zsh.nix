{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.zplug;
in {
  options.zsh = {
    enable = mkEnableOption "zsh";
    osUser = mkOption {type = types.str;};
  };

  config = {
    home-manager.users.${cfg.osUser}.programs.zsh = mkIf cfg.enable {
      enable = cfg.enable;
      enableAutosuggestions = true;
      enableCompletion = true;
      #syntaxHighlighting = { enable = true; };
      #zsh-abbr = { enable = true; };

      initExtra = " eval \"$(fnm env --use-on-cd)\" ";

      dotDir = ".config/zsh";
      zplug.enable = true;

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        #        ignoreAllDups = true;
        ignoreSpace = true;
        save = 5000;
        size = 1000000000;
        path = "$XDG_DATA_HOME/zsh/zsh_history";
      };
    };
  };
}
