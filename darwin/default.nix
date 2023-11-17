#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix *
#       └─ <host>.nix
#
{
  lib,
  inputs,
  nixpkgs,
  darwin,
  home-manager,
  vars,
  agenix,
  ...
}: let
  system = "aarch64-darwin";
  darwinVars = {
    inherit (vars) editor user;
  };
  legacy = nixpkgs.legacyPackages.${system};
  commonModules =
    [
      home-manager.darwinModules.home-manager
      {
        # Home-Manager Module
        home-manager.useGlobalPkgs = true;
        #home-manager.useUserPackages = true;
      }
    ]
    ++ (import ../modules ++ import ./modules);
in {
  Alis-MacBook-Pro-2 = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit inputs darwinVars legacy agenix;};
    modules = [./work.nix] ++ commonModules;
  };

  Alis-Macbook-Air = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit inputs darwinVars legacy agenix;};
    modules = [./personal.nix] ++ commonModules;
  };
}
