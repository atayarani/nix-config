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
  # home = {};
  home = {
    username = "${nixVars.user}";
    homeDirectory = "/home/${nixVars.user}";
    packages = [pkgs.home-manager];
    stateVersion = "23.11";
  };

  # programs.git =
}
