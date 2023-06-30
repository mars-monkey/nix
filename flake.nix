{
  description = "mars-monkey's NixOS system configuration flake";
  
  inputs.nixpkgs.url = github:NixOS/nixpkgs;
  
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
