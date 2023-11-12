{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nvim;
in {
  options.nvim = {
    enable = mkEnableOption "nvim";
    osUser = mkOption {type = types.str;};
  };

  config = mkIf cfg.enable {
    home-manager.users.${cfg.osUser} = {
      programs.neovim = {
        enable = cfg.enable;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        defaultEditor = true;
      };
    };
  };
}
