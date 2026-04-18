{
  imports = [
    ./bash.nix
    ./git.nix
    ./nvim.nix
    ./direnv.nix
    ./gh.nix
    ./gpg-agent.nix
    ./firefox.nix
  ];

  programs.ripgrep.enable = true;

  programs.password-store.enable = true;

  programs.jq.enable = true;

  programs.htop.enable = true;

  programs.alacritty.enable = true;

  programs.waybar.enable = true;

  programs.fuzzel.enable = true;

  programs.swaylock.enable = true;

  custom.pgp.enable = true;

  programs.vesktop.enable = true;
}
