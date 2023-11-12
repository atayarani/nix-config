# poetry poetry-env pip pipenv python
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.python;
in {
  options.python = {
    enable = mkEnableOption "python";

    osUser = mkOption {type = types.str;};
    zplug = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    homebrew.brews = ["pyenv"];
    home-manager.users.${cfg.osUser} = {
      # programs.pyenv = {
      #   enable = cfg.enable;
      # };

      programs.zsh.zplug.plugins = mkIf cfg.zplug [
        {
          name = "plugins/poetry";
          tags = [from:oh-my-zsh];
        }
        {
          name = "plugins/poetry-env";
          tags = [from:oh-my-zsh];
        }
        {
          name = "plugins/pip";
          tags = [from:oh-my-zsh];
        }
        {
          name = "plugins/pipenv";
          tags = [from:oh-my-zsh];
        }
        {
          name = "plugins/python";
          tags = [from:oh-my-zsh];
        }
        {name = "mattberther/zsh-pyenv";}
      ];
    };
  };
}
