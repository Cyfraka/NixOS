{
  description = "Cyfraka NixOS and Home Manager configuration using unstable nixpkgs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        x1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/x1/configuration.nix ];
        };
        x230 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/x230/configuration.nix ];
        };
      };
      homeConfigurations = {
        cyfraka = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./modules/home.nix ];
        };
      };
    };
}
