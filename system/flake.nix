{
  description = "mars-monkey's NixOS system configuration flake";
  
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations.mars-monkey-machine = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./hardware-configuration.nix ];
      };
    };
}
