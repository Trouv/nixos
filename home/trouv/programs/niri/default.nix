{systemSettings, ...}: {
  programs.niri.settings = {
    input.touchpad = {
      tap = true;
      natural-scroll = true;
    };

    layout = {
      preset-column-widths = [
        {proportion = 1. / 4.;}
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
        {proportion = 3. / 4.;}
      ];

      default-column-width = {proportion = systemSettings.landscapeWidthProportion / 2.;};

      focus-ring.enable = false;
      border.enable = false;

      always-center-single-column = true;

      gaps = 8;
    };

    spawn-at-startup = [
      {argv = ["waybar"];}
      {
        sh = ''
          kitty \
            --hold \
            kopia repository connect server \
              --url https://192.168.0.4:51515/ \
              --server-cert-fingerprint 73fa21b188d22957ed2a6635e1fb994ff6fd9546d02e0e14f2469cf5a0eb175a
        '';
      }
    ];

    animations.workspace-switch.enable = false;

    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};
      "Mod+Return" = {
        action.spawn = "kitty";
        hotkey-overlay.title = "Open terminal";
      };
      "Mod+D" = {
        action.spawn = "fuzzel";
        hotkey-overlay.title = "Open app launcher";
      };
      "Mod+Alt+L" = {
        action.spawn = "swaylock";
        hotkey-overlay.title = "Lock screen";
      };

      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
      "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
      "XF86AudioNext".action.spawn = ["playerctl" "next"];

      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "10%+"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10%-"];

      "Mod+O".action.toggle-overview = {};
      "Mod+Q".action.close-window = {};

      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      "Mod+Shift+Left".action.move-column-left = {};
      "Mod+Shift+Down".action.move-window-down = {};
      "Mod+Shift+Up".action.move-window-up = {};
      "Mod+Shift+Right".action.move-column-right = {};
      "Mod+Shift+H".action.move-column-left = {};
      "Mod+Shift+J".action.move-window-down = {};
      "Mod+Shift+K".action.move-window-up = {};
      "Mod+Shift+L".action.move-column-right = {};

      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};
      "Mod+Shift+Home".action.move-column-to-first = {};
      "Mod+Shift+End".action.move-column-to-last = {};

      "Mod+Ctrl+Left".action.focus-monitor-left = {};
      "Mod+Ctrl+Down".action.focus-monitor-down = {};
      "Mod+Ctrl+Up".action.focus-monitor-up = {};
      "Mod+Ctrl+Right".action.focus-monitor-right = {};
      "Mod+Ctrl+H".action.focus-monitor-left = {};
      "Mod+Ctrl+J".action.focus-monitor-down = {};
      "Mod+Ctrl+K".action.focus-monitor-up = {};
      "Mod+Ctrl+L".action.focus-monitor-right = {};

      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+U".action.focus-workspace-down = {};
      "Mod+I".action.focus-workspace-up = {};
      "Mod+Shift+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Shift+Page_Up".action.move-column-to-workspace-up = {};
      "Mod+Shift+U".action.move-column-to-workspace-down = {};
      "Mod+Shift+I".action.move-column-to-workspace-up = {};

      "Mod+Ctrl+Page_Down".action.move-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-workspace-up = {};
      "Mod+Ctrl+U".action.move-workspace-down = {};
      "Mod+Ctrl+I".action.move-workspace-up = {};

      "Mod+1".action.focus-workspace = "1";
      "Mod+2".action.focus-workspace = "2";
      "Mod+3".action.focus-workspace = "3";
      "Mod+4".action.focus-workspace = "4";
      "Mod+5".action.focus-workspace = "5";
      "Mod+6".action.focus-workspace = "6";
      "Mod+7".action.focus-workspace = "games";
      "Mod+8".action.focus-workspace = "media";
      "Mod+9".action.focus-workspace = "web";
      "Mod+0".action.focus-workspace = "chat";
      "Mod+Shift+1".action.move-column-to-workspace = "1";
      "Mod+Shift+2".action.move-column-to-workspace = "2";
      "Mod+Shift+3".action.move-column-to-workspace = "3";
      "Mod+Shift+4".action.move-column-to-workspace = "4";
      "Mod+Shift+5".action.move-column-to-workspace = "5";
      "Mod+Shift+6".action.move-column-to-workspace = "6";
      "Mod+Shift+7".action.move-column-to-workspace = "games";
      "Mod+Shift+8".action.move-column-to-workspace = "media";
      "Mod+Shift+9".action.move-column-to-workspace = "web";
      "Mod+Shift+0".action.move-column-to-workspace = "chat";

      "Mod+Comma".action.consume-window-into-column = {};
      "Mod+Period".action.expel-window-from-column = {};

      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};

      "Mod+R".action.switch-preset-column-width = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+C".action.center-column = {};

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Shift+V".action.toggle-window-floating = {};
      "Mod+V".action.switch-focus-between-floating-and-tiling = {};

      "Mod+W".action.toggle-column-tabbed-display = {};

      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      "Mod+Shift+E".action.quit = {};

      "Mod+Shift+P".action.power-off-monitors = {};
    };

    workspaces = {
      "1" = {};
      "2" = {};
      "3" = {};
      "4" = {};
      "5" = {};
      "6" = {};
      "w".name = "games";
      "x".name = "media";
      "y".name = "web";
      "z".name = "chat";
    };

    window-rules = [
      {
        matches = [{app-id = "^vesktop$";}];
        open-on-workspace = "chat";
        default-column-width.proportion = systemSettings.landscapeWidthProportion;
      }
      {
        matches = [{app-id = "^firefox$";}];
        open-on-workspace = "web";
        default-column-width.proportion = systemSettings.landscapeWidthProportion;
      }
      {
        matches = [{app-id = "^.*Tonearm$";}];
        open-on-workspace = "media";
        default-column-width.proportion = systemSettings.landscapeWidthProportion;
      }
      {
        matches = [{app-id = "^(steam|heroic|.*RetroArch|.*Lutris)$";}];
        open-on-workspace = "games";
        default-column-width.proportion = systemSettings.landscapeWidthProportion;
      }
      # non-primary steam windows open in smaller windows
      {
        matches = [{app-id = "^steam$";}];
        excludes = [{title = "^Steam$";}];
        open-on-workspace = "games";
        default-column-width.proportion = systemSettings.landscapeWidthProportion / 2.;
      }
      {
        matches = [{app-id = "^kitty$";}];
        background-effect.blur = true;
        default-column-width.proportion = systemSettings.landscapeWidthProportion / 2.;
      }
    ];
  };
}
