{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.gh;
in {
  options.gh = {
    enable = mkEnableOption "git";
    user = mkOption {type = types.str;};
    editor = mkOption {type = types.str;};
    zplug = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${cfg.user} = {
      programs.gh = {
        enable = cfg.enable;
        settings = {
          aliases = {co = "pr checkout";};
          git_protocol = "https";
          editor = cfg.editor;
        };
      };

      programs.zsh.zplug.plugins = [
        (mkIf cfg.zplug {
          name = "plugins/gh";
          tags = [from:oh-my-zsh];
        })
      ];
    };
  };
}
