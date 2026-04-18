{
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = with builtins; let
        extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
      in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
          (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
        ];
      /*
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url:
      export SHORT_ID=<short id>

      # Then, download the XPI by filling it in to the install_url template, unzip it,
      curl --fail --location --silent https://addons.mozilla.org/EN-US/firefox/downloads/latest/$SHORT_ID/latest.xpi -O
      unzip -p latest.xpi manifest.json | jq --raw-output .browser_specific_settings.gecko.id
      rm latest.xpi
      */
      SearchEngines.Default = "DuckDuckGo";
    };
  };
}
