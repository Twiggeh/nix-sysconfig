# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ nixpkgs, config, user, pkgs, ... } :
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      version = 2;
      devices = [ "nodev" ];
      useOSProber = true;
      efiSupport = true;
      configurationLimit = 5;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernel.sysctl = { "vm.swappiness" = 0; };

  hardware = {
		opengl.enable = true;
		nvidia = {
			powerManagement = {
				enable = true;	
				finegrained = true;
			};
			modesetting.enable = true;
			package = config.boot.kernelPackages.nvidiaPackages.beta;
		  prime = {
		  	offload.enable = true;
		  	nvidiaBusId = "PCI:1:0:0";
		  	amdgpuBusId = "PCI:6:0:0";
		  };
		};
	};
	
  networking = {
    hostName = "${user}-laptop";
    networkmanager.enable = true;
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
    neovim
    wget
    pciutils
    firefox
    brave
    google-chrome
    git
    tmux
    xdg-desktop-portal-wlr
		pulseaudio
		nvidia-offload
		docker
  ];

  system.stateVersion = "22.05";

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  security.rtkit.enable = true;

  services = {
		xserver.videoDrivers = [ "nvidia" ];
    pipewire = {
      enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
      wireplumber = { enable = true; };
    };
  };

	fonts.fonts = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" ]; })
	];

	networking.firewall = {
		allowedTCPPorts = [ 9090 ];	
		allowedUDPPorts = [ 9090 ];	
	};
} 
