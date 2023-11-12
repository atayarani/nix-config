{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.oh-my-posh;
in {
  options.oh-my-posh = {
    enable = mkEnableOption "oh-my-posh";
    osUser = mkOption {type = types.str;};
    blocks = mkOption {description = mdDoc ''Prompt Segments to Include'';}; # type = types.inferred;
  };

  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser}.programs.oh-my-posh = {
      enable = true;
      settings = {
        version = 2;
        console_title_template = "{{.Folder}}{{if .Root}} ::  {{.Shell}}";
        final_space = true;
        pwd = "osc99";
        shell_integration = true;

        blocks = cfg.blocks;
      };
    };
  };
}
