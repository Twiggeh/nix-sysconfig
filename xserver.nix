{ ... }: {
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      defaultSession = "xfce";
    };
    desktopManager = { xfce.enable = true; };
    layout = "de";
    videoDrivers = [ "amd" ];
    xkbVariant = "";
    libinput = { enable = true; };
  };
}
