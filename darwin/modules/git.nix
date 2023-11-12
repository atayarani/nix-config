{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.git;
in {
  options.git = {
    enable = mkEnableOption "git";
    osUser = mkOption {type = types.str;};
    userName = mkOption {
      type = types.str;
      default = null;
      description = mdDoc ''
        Git User Name
      '';
    };
    userEmail = mkOption {
      type = types.str;
      default = null;
      description = mdDoc ''
        Git User Email
      '';
    };
    zplug = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser} = {
      programs.git = {
        enable = config.git.enable;
        diff-so-fancy = {enable = true;};
        lfs = {enable = true;};
        userEmail = config.git.userEmail;
        userName = config.git.userName;
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
      programs.zsh.zplug.plugins = [
        (mkIf cfg.zplug {
          name = "plugins/git";
          tags = [from:oh-my-zsh];
        })
        #git-auto-fetch gitignore
      ];
    };
  };
}
