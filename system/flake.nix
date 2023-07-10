{
  description = "mars-monkey's NixOS system configuration flake";
  
  inputs.nixpkgs.url = github:NixOS/nixpkgs;
  
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.mars-monkey-machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ./hardware-configuration.nix ];
    };
  };
}
