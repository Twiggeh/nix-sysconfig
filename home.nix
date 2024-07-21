{ pkgs, config, lib, inputs, ... } :
{
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    neofetch
    playerctl
    brightnessctl
    kitty
    alacritty
    slurp
    grim
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
}
