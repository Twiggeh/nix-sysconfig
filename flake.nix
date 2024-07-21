{
	inputs = {
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware }: 
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
			user = "albert";
		in {
			nixosConfigurations = {
				${user} = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit user; };
					inherit system;
					modules = [
						nixos-hardware.nixosModules.asus-battery
						./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.${user} = import ./home.nix;
						}
					];
				};
			};
		};
}

