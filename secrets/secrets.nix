let
  users = {
    xaolan = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvbECt/Gs84TqIJgnAlO9tWm2xMKu6w6duDXEt9I8Ar xaolan@Yunara"
    ];
  };

  hosts = {
    Yunara = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+BG/rB/QPW5gDjouZnrWKPuRUeKzfAGG1xzZHLCHNs"
    ];
  };
in {
  "secret1.age".publicKeys = users.xaolan;
  "secret2.age".publicKeys = hosts.Yunara;

  "bak_sak.age".publicKeys = users.xaolan;
  "mc_rcon.age".publicKeys = users.xaolan ++ hosts.Seraphine;
}
