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
  userName = "ChronoSerrano";
  userEmail = "619512+ChronoSerrano@users.noreply.github.com";
 };
}
