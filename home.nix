{ pkgs, config, lib, ... }: {
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    neofetch
    playerctl
    brightnessctl
    kitty
    slurp
    grim
    waybar
    wofi
    wofi-emoji
		krita
		ffmpeg
		ranger
		insomnia
		mpv
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ nixfmt rnix-lsp ]);
  };
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
  home.file.".config/hypr/hyprland.conf" = {
    source = ./hyprland/hyprland.conf;
  };
  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };
}
