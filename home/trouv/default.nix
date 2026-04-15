{pkgs, ...}: {
  imports = [
    ./programs
  ];

  home.username = "trouv";
  home.homeDirectory = "/home/trouv";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "25.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    proggyfonts
  ];
}
