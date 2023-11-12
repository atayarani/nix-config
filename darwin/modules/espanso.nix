{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.espanso;
  generateYaml = (pkgs.formats.yaml {}).generate;

  espansoConfig = "espanso/config/default.yml";
  espansoMatch = "espanso/match/base.yml";
  matches = [
    # {
    #   trigger = ":espanso";
    #   replace = "Hi there!";
    # }
    # {
    #   trigger = ":date";
    #   replace = "{{mydate}}";
    #   vars = [
    #     {
    #       name = "mydate";
    #       type = "date";
    #       params = {
    #         format = "%m/%d/%Y";
    #       };
    #     }
    #   ];
    # }
    # {
    #   trigger = ":anon-email";
    #   replace = "b2lrzgvraw.anonaddy.me";
    # }
  ];
in {
  options.espanso = {
    enable = mkEnableOption "espanso";
    osUser = mkOption {type = types.str;};
    config = mkOption {default = {};}; # type = types.attrsOf types.inferred;
    match = mkOption {default = [];}; # type = types.listOf types.inferred;
  };

  # visit the official docs at: https://espanso.org/docs/
  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser} = {
      xdg.configFile.${espansoConfig}.source = generateYaml "espansoConfig" cfg.config;
      xdg.configFile.${espansoMatch}.source = generateYaml "espansoMatch" {matches = cfg.match ++ matches;};
    };

    homebrew.casks = ["espanso"];
  };
}
