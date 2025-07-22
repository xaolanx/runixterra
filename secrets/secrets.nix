let
  users = {
    xaolan = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZjHWTqLOqwSWwv2XRNqRoflnJ0UoIB2SMvkBfdQFKM xaolan@Yunara"
    ];
  };

  hosts = {
    Yunara = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhnOhARXjo+jagLOi5Qah3P8G10K8Lfe3ZfXL8VSyU+"
    ];
  };
in {
  "secret1.age".publicKeys = users.xaolan;
  "secret2.age".publicKeys = hosts.Yunara;

  "bak_sak.age".publicKeys = users.xaolan;
  "mc_rcon.age".publicKeys = users.xaolan ++ hosts.Seraphine;
}
