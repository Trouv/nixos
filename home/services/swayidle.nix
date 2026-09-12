{pkgs, ...}: {
  services.swayidle = let
    # Lock command
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    # Display command
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    enable = true;
    timeouts = let
      activeIntervalSeconds = 120;
      escalateIntervalSeconds = 30;
    in [
      {
        timeout = activeIntervalSeconds; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in ${escalateIntervalSeconds} seconds' -t ${escalateIntervalSeconds * 1000}";
      }
      {
        timeout = activeIntervalSeconds + escalateIntervalSeconds;
        command = lock;
      }
      {
        timeout = activeIntervalSeconds + (2 * escalateIntervalSeconds);
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = activeIntervalSeconds + (3 * escalateIntervalSeconds);
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = {
      "before-sleep" = (display "off") + "; " + lock;
      "after-resume" = display "on";
      "lock" = (display "off") + "; " + lock;
      "unlock" = display "on";
    };
  };
}
