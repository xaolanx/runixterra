{pkgs, ...}: {
  users.users.xaolan = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
    ];
  };
}
