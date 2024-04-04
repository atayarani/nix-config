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
        mouse = true;
        tmuxinator.enable = true;
        extraConfig = ''
            set -g status-right '#[fg=white]%Y-%m-%d %H:%M#[default]'

            # Reload tmux config
            bind r source-file ~/.config/tmux/tmux.conf

            # Pane navigation
            bind -n M-Left select-pane -L
            bind -n M-Right select-pane -R
            bind -n M-Up select-pane -U
            bind -n M-Down select-pane -D

            # split panes using \ and -
            bind '\' split-window -h
            bind - split-window -v
            unbind '"'
            unbind %
        '';
        prefix = "C-a";
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
