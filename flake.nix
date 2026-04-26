# /////////////////////////
# //                     //
# //     Nix Flakes :    //
# //                     //
# //        Main         //
# //                     //
# /////////////////////////

{
  description = "NixOS Flake Configuration with Dendritic Pattern";

  inputs = {
    # // Nixpkgs Unstable //
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # // Home-manager //
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    niri.url = "github:YaLTeR/niri";
  };

  outputs = inputs@{ flake-parts, nixpkgs, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [];
      flake = {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nixos/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages =  true;
                users.theanontrarrr = import ./home/theanontrarrr/default.nix;
                backupFileExtension = "backup";
                lib.homeManagerConfiguration {
                  pkgs = nixpkgs.legacyPackages.x86_64-linux;
                  extraSpecialArgs = { inherit inputs; };
                  modules = [ ./home/theanontrarrr/default.nix ];
                };
              };
            }
          ];
        };
      };
  };
}
