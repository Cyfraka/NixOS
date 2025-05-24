{

  description = "Cyfraka";

  inputs = {

    nixpkgs.url = "nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        ThinkPad-X1-Carbon = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
      };
    };
      homeConfigurations = {
        cyfraka = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };  
      };
    };
}
