{
  description = "Twig System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, hyprland, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user = "albert";
    in {
      nixosConfigurations = {
        ${user} = lib.nixosSystem {
          specialArgs = { inherit user; };
          inherit system;
          modules = [
            ./configuration.nix
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = { imports = [ ./home.nix ]; };
            }
          ];
        };
      };
    };
}
