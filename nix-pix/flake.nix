{
  description = "Nix 4 Pix";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix ( Consistent Theming ) Figure out stuff to slap that on maybe.
    stylix.url = "github:danth/stylix";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland"

  };

  outputs = {
    self,
    nixpkgs,
    stylix,
    home-manager,
    ...
  } @ inputs: let 
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
  in {
    overlays = import ./overlays { inherit inputs; };
    
    nixosConfiguration = {
      nier = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        ## >> Main Nixos Configuration File << ##
        modules = [
          stylix.nixosModules.stylix

          ./hosts/nier/Configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.pix = import ./hosts/nier/pix_home.nix;
            home-manager.extraSpecialArgs = { inherit inputs outputs; };
          }
        ];
      };
    };
  };
}
