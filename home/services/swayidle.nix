{pkgs, ...}: {
  services.swayidle = let
    # Lock command
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    # Display command
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    enable = true;
    timeouts = [
      {
        timeout = 50; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 10000";
      }
      {
        timeout = 60;
        command = lock;
      }
      {
        timeout = 90;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 120;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        # adding duplicated entries for the same event may not work
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
      {
        event = "unlock";
        command = display "on";
      }
    ];
  };
}
