{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.aws;
in {
  options.aws = {
    enable = mkEnableOption "aws";
    osUser = mkOption {type = types.str;};
    zplug = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser} = {
      # programs.awscli = {
      #   enable = cfg.enable;
      # };

      programs.zsh.zplug.plugins = [
        (mkIf cfg.zplug {
          name = "plugins/aws";
          tags = [from:oh-my-zsh];
        })
      ];
    };
  };
}
