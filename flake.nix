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
    niri.url = "github:sodiboo/niri-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
      };
  };
}
