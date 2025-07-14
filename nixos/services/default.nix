{
  imports = [
  	./backlight.nix
  	./gnome-services.nix
  	# ./greetd.nix
  	./location.nix
  	./pipewire.nix
  	./power.nix
  	./warp.nix
  	# ./swayosd.nix
  ];
  
  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
