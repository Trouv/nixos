{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = let
    scriptFolder = ./scripts;
    scriptPath = name: value: scriptFolder + ("/" + name);
    filterScripts = key: value: value == "regular" && lib.hasSuffix ".nix" key;
    scriptPaths = lib.mapAttrsToList scriptPath (lib.filterAttrs filterScripts (builtins.readDir scriptFolder));
    pathToScriptBin = path: pkgs.writeShellScriptBin (lib.removeSuffix ".nix" (baseNameOf path)) (import path);
  in
    map pathToScriptBin scriptPaths;
}
