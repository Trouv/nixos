{
  lib,
  config,
  ...
}: {
  options.nvidia.enable = lib.mkEnableOption "nvidia proprietary drivers";

  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
  };
}
