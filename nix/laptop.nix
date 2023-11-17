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
  git = {
    enable = true;
    osUser = hostVars.user;
    userName = "ChronoSerrano";
    userEmail = "619512+ChronoSerrano@users.noreply.github.com";
  };
}
