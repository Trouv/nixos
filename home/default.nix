{
  pkgs,
  systemSettings,
  ...
}: {
  imports = [
    ./programs
    ./services
  ];

  home.username = systemSettings.primaryUser.username;
  home.homeDirectory = "/home/${systemSettings.primaryUser.username}";

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

    tree

    # opens when you click on waybar audio module
    pavucontrol
  ];
}
