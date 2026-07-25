{
  imports = [
    ./bash.nix
    ./git.nix
    ./nvim.nix
    ./direnv.nix
    ./gh.nix
    ./gpg-agent.nix
    ./firefox.nix
    ./waybar
    ./niri
  ];

  programs.ripgrep.enable = true;

  programs.password-store.enable = true;

  programs.jq.enable = true;

  programs.htop.enable = true;

  programs.kitty.enable = true;

  programs.fuzzel.enable = true;

  programs.swaylock.enable = true;

  custom.pgp.enable = true;

  programs.vesktop.enable = true;

  # showoff
  programs.fastfetch.enable = true;
}
