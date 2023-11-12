{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tmux;
in {
  options.tmux = {
    enable = mkEnableOption "tmux";
    osUser = mkOption {type = types.str;};
    zplug = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser} = {
      programs.tmux = {
        enable = cfg.enable;
        clock24 = true;
      };
      programs.zsh.zplug.plugins = [
        (mkIf cfg.zplug {
          name = "plugins/tmux";
          tags = [from:oh-my-zsh];
        })
        # tmuxinator
      ];
    };
  };
}
