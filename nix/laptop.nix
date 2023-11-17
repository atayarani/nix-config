#
#  Nix Setup using Home-manager
#
#  flake.nix
#   └─ ./nix
#       ├─ default.nix
#       └─ laptop.nix *
#
{
  config,
  inputs,
  pkgs,
  nixVars,
  vars,
  ...
}: let
  hostVars = {
    inherit (nixVars) editor user;
  };
in {
  home = {};

  programs.git = {
    enable = true;
    diff-so-fancy = {enable = true;};
    lfs = {enable = true;};
    userName = "ChronoSerrano";
    userEmail = "619512+ChronoSerrano@users.noreply.github.com";
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

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        kamadorueda.alejandra
      ];
      mutableExtensionsDir = false;
    };

    aliases = {track = "!f() { git branch --set-upstream-to=origin/\"$1\" \"$1\"; }; f";};
  };
}
