{ config, pkgs, lib, nixvim, ... }:

let
  user = "ali";
  xdg_configHome  = "/home/${user}/.config";
shared-programs = import ../shared/home-manager.nix { inherit config pkgs lib nixvim; };
#shared-files = import ../shared/files.nix { inherit config pkgs; };
in {
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    #file = shared-files // import ./files.nix { inherit user pkgs; };
    stateVersion = "23.11";
      sessionVariables = {
        EDITOR = "nvim";
      };
  };


  programs = shared-programs;
}