{
  imports = [
    ./bash.nix
    ./git.nix
    ./nvim.nix
    ./direnv.nix
    ./gh.nix
    ./niri.nix
  ];

  programs.ripgrep.enable = true;

  programs.password-store.enable = true;

  programs.jq.enable = true;

  programs.htop.enable = true;
}
