# Darwin
---
# Nix
---
> Currently the only host available is `victus`

1) `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`
2) `nix build --extra-experimental-features 'nix-command flakes' .#homeConfigurations.victus.activationPackage`
3) `./result/activate`
4) `home-manager switch --flake .#victus`
# NixOS
---
