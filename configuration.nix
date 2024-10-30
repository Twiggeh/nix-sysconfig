# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ nixPkgs, config, user, pkgs, ... } :
let
	nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
		export __NV_PRIME_RENDER_OFFLOAD=1
		export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
		export __GLX_VENDOR_LIBRARY_NAME=nvidia
		export __VK_LAYER_NV_optimus=NVIDIA_only
		exec "$@"
	'';
in {
	nixpkgs.config.allowUnfree = true;
	imports = [ ./hardware-configuration.nix ];
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

	programs.hyprland.enable = true;

	boot = {
		loader = {
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
			grub = {
				enable = true;
				devices = [ "nodev" ];
				useOSProber = true;
				efiSupport = true;
				configurationLimit = 5;
			};
		};
		swraid.enable = false;
		kernel.sysctl = { "vm.swappiness" = 0; };
	};

	hardware = {
		asus.battery = {
			chargeUpto = 60;
		};
		opengl = {
			enable = true;
			# enable32Bit = true;
		};
		nvidia = {
			modesetting.enable = true;
			powerManagement = {
				enable = true;
				finegrained = true;
			};
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			dynamicBoost.enable = true;
			prime = {
				offload = {
					enable = true;
					enableOffloadCmd = true;
				};
				nvidiaBusId = "PCI:1:0:0";
				amdgpuBusId = "PCI:6:0:0";
			};
		};
		bluetooth = {
			enable = true;
			settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
		};
		opentabletdriver = {
			enable = true;
			daemon.enable = true;
		};
	};
	
	networking = {
		hostName = "${user}-laptop";
		networkmanager.enable = true;
		extraHosts = ''
			127.0.0.1 twig.com
		'';
		firewall = {
			allowedTCPPorts = [ 3000 5173 5174 4173 6001 ];
			allowedUDPPorts = [ 3001 5173 5174 4173 6001 ];
		};
	};

	time.timeZone = "Europe/Berlin";

	i18n = {
		defaultLocale = "en_US.utf8";
		extraLocaleSettings = {
			LC_ADDRESS = "de_DE.utf8";
			LC_IDENTIFICATION = "de_DE.utf8";
			LC_MEASUREMENT = "de_DE.utf8";
			LC_MONETARY = "de_DE.utf8";
			LC_NAME = "de_DE.utf8";
			LC_NUMERIC = "de_DE.utf8";
			LC_PAPER = "de_DE.utf8";
			LC_TELEPHONE = "de_DE.utf8";
			LC_TIME = "de_DE.utf8";
		};
	};

	console.keyMap = "de";

	users.users.${user} = {
		isNormalUser = true;
		description = user;
		extraGroups = [ "networkmanager" "wheel" "video" "lp" "scanner" "docker" "plugdev" ];
	};

	environment.systemPackages = with pkgs; [
		# all for nvim
		neovim
		ripgrep
		fd
		wl-clipboard
		nodejs_22
		typescript
		gcc
		gnumake
		unzip
		lua-language-server
		vscode.fhs 
		wget
		pciutils
		firefox
		brave
		google-chrome
		git
		tmux

		# my packages
		openvpn
		obs-studio
		kdenlive
		lazygit

		# all for Hyprland
		dunst
		libsForQt5.qt5.qtwayland
		qt6.qtwayland
		swww
		egl-wayland
		wayland-scanner

		docker
		# lens
		k9s
		kubectl

		# keyboard fix
		keyd
		# gnome-shell-extension-keyman

		# for opengl
		glib
		libGL

		#gpu
		lact
		nvidia-offload
		supergfxctl

		#usb
		usbutils
		udiskie
		udisks
	];

	system.stateVersion = "22.05";

	nix = {
		# package = pkgs.nixFlakes;
		package = pkgs.nixVersions.git;
		extraOptions = "experimental-features = nix-command flakes";
	};

	security = {
		rtkit.enable = true;
		polkit.enable = true;
	};


	systemd.services.lactd = {
		description = "AMDGPU Control Daemon";
		enable = true;  
		serviceConfig = {
			ExecStart = "${pkgs.lact}/bin/lact daemon";
		};
		wantedBy = ["multi-user.target"];
	};


	services = {
		gvfs.enable = true;
		udisks2.enable = true;
		xserver.videoDrivers = [ "nvidia" ];
		asusd.enable = true;
		keyd = {
			enable = true;
			keyboards = {
				default = {
					ids = ["*"];
					settings = {
						main = {
							capslock = "esc";
						};
					};
				};
			};
		};
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};
	};

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" ]; })
	];
} 
