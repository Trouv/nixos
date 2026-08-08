{
  lib,
  config,
  ...
}: {
  options.nvidia.enable = lib.mkEnableOption "nvidia proprietary drivers";

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
