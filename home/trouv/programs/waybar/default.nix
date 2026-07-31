# This is mostly the default waybar config but with minor adjustments:
# - 12 hour clock
# - unused modules removed
# - niri workspaces on the left
# - some spaces after icons that were getting cut off
# - removed keyboard-state module
{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      spacing = 10;
      modules-left = ["niri/workspaces"];
      modules-right = [
        "mpd"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "battery"
        "battery#bat2"
        "clock"
        "tray"
        "custom/power"
      ];
      "mpd" = {
        format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime =%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
        format-disconnected = "Disconnected ";
        format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        unknown-tag = "N/A";
        interval = 5;
        consume-icons = {
          on = "";
        };
        random-icons = {
          off = "<span color=\"#f53c3c\"></span>";
          on = "";
        };
        repeat-icons = {
          on = "";
        };
        single-icons = {
          on = "1";
        };
        state-icons = {
          paused = "";
          playing = "";
        };
        tooltip-format = "MPD (connected)";
        tooltip-format-disconnected = "MPD (disconnected)";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      "tray" = {
        spacing = 10;
      };
      "clock" = {
        format = "{:%I:%M %p}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      "cpu" = {
        format = "{usage}% ";
        tooltip = false;
      };
      "memory" = {
        format = "{}% ";
      };
      "temperature" = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = ["󰉬" "" "󰉪"];
      };
      "backlight" = {
        # "device" = "acpi_video1";
        format = "{percent}% {icon}";
        format-icons = ["" "" "" "" "" "" "" "" ""];
      };
      "battery" = {
        states = {
          # "good" = 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% 󰃨";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        # "format-good" = ""; // An empty format will hide the module
        # "format-full" = "";
        format-icons = [" " " " " " " " " "];
      };
      "battery#bat2" = {
        bat = "BAT2";
      };
      "power-profiles-daemon" = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = " ";
          performance = " ";
          balanced = " ";
          power-saver = " ";
        };
      };
      "network" = {
        # "interface" = "wlp2*"; // (Optional) To force the use of this interface
        format-wifi = "{essid} ({signalStrength}%)  ";
        format-ethernet = "{ipaddr}/{cidr} 󰊗";
        tooltip-format = "{ifname} via {gwaddr} 󰊗";
        format-linked = "{ifname} (No IP) 󰊗";
        format-disconnected = "Disconnected ⚠";
        format-alt = "{ifname} = {ipaddr}/{cidr}";
      };
      "pulseaudio" = {
        # "scroll-step" = 1; // %, can be a float
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "󰅶 {icon} {format_source}";
        format-muted = "󰅶 {format_source}";
        format-source = "{volume}%  ";
        format-source-muted = " ";
        format-icons = {
          headphone = "";
          hands-free = "󰂑";
          headset = "󰂑";
          phone = "";
          portable = "";
          car = "";
          default = [" " " " " "];
        };
        on-click = "pavucontrol";
      };
      "custom/power" = {
        "format" = "⏻ ";
        "tooltip" = false;
        "menu" = "on-click";
        "menu-file" = "$HOME/.config/waybar/power_menu.xml"; # Menu file in resources folder
        "menu-actions" = {
          "shutdown" = "shutdown";
          "reboot" = "reboot";
          "suspend" = "systemctl suspend";
          "hibernate" = "systemctl hibernate";
        };
      };
    };
  };
  xdg.configFile."waybar" = {
    recursive = true;
    source = ./dot;
  };

  stylix.targets.waybar.font = "sansSerif";
}
