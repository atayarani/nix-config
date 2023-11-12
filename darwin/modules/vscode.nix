{
  config,
  lib,
  pkgs,
  legacy,
  ...
}:
with lib; let
  cfg = config.vscode;
in {
  options.vscode = {
    enable = mkEnableOption "vscode";
    osUser = mkOption {type = types.str;};
    additionalPlugins = mkOption {default = [];}; # type = types.listOf types.inferred;
    zplug = mkOption {
      type = types.bool;
      default = true;
    };
  };

  # visit the official docs at: https://espanso.org/docs/
  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser} = {
      programs.vscode = {
        enable = true;
        extensions = with legacy.vscode-extensions;
          [
            jnoortheen.nix-ide
            kamadorueda.alejandra
          ]
          ++ cfg.additionalPlugins;
        mutableExtensionsDir = false;
      };

      programs.zsh.zplug.plugins = [
        (mkIf cfg.zplug {
          name = "plugins/vscode";
          tags = [from:oh-my-zsh];
        })
      ];
    };
  };
}
