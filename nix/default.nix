#
#  These are the diffent profiles that can be used when using Nix on other distros.
#  Home-Manager is used to list and customize packages.
#
#  flake.nix
#   └─ ./nix
#       ├─ default.nix *
#       └─ <host>.nix
#
{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  vars,
  nixvim,
  ...
}: let
  system = "x86_64-linux"; # System Architecture
  pkgs = nixpkgs.legacyPackages.${system};
  nixVars = {
    inherit (vars) editor user;
  };
in {
  victus = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs nixVars vars;};

    modules = [
      # Modules Used
      ./laptop.nix
      ../modules/nix/home-manager.nix
      nixvim.homeManagerModules.nixvim
      # {
      #   home = {
      #     username = "${vars.user}";
      #     homeDirectory = "/home/${vars.user}";
      #     packages = [pkgs.home-manager];
      #     stateVersion = "23.11";
      #   };
      # }
    ]; # ++ (import ../modules/nix/home-manager.nix);
  };
}
