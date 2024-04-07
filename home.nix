{ pkgs, config, lib, ... }: {
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    neofetch
    playerctl
    brightnessctl
    kitty
		alacritty
		slurp
		grim
		waybar
		wofi
		wofi-emoji
		krita
		ffmpeg
		ranger
		ueberzugpp
		insomnia
		mpv
		rocmPackages.rocm-smi
  ];
  # home.file.".config/kitty" = {
  #   source = ./kitty;
  #   recursive = true;
  # };
}
