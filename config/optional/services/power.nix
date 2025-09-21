_: {
  services = {
    power-profiles-daemon.enable = true;

    # battery info
    upower.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}
