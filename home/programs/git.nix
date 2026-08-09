{systemSettings, ...}: {
  programs.git = {
    enable = true;
    settings.user.name = systemSettings.primaryUser.fullname;
    settings.user.email = systemSettings.primaryUser.email;

    # direnv files, don't want to commit these
    ignores = [".envrc" ".direnv"];
  };

  # diffs that look more like github
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
