{
  imports = [./swayidle.nix];

  services.wpaperd.enable = true;

  # notification daemon
  services.mako.enable = true;
}
