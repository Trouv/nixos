{
  programs.git = {
    enable = true;
    settings.user.name = "Trevor Lovell";
    settings.user.email = "trevorlovelldesign@gmail.com";

    # direnv files, don't want to commit these
    ignores = [".envrc" ".direnv"];
  };

  # diffs that look more like github
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
