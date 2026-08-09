{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash.shellAliases = {
    direnv-flake = "echo \"use flake\" >> .envrc && direnv allow";
  };
}
