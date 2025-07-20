let
  users = {
    xaolan = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICELSL45m4ptWDZwQDi2AUmCgt4n93KsmZtt69fyb0vy"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZTLQQzgCvdaAPdxUkpytDHgwd8K1N1IWtriY4tWSvn"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZvsZTvR5wQedjnuSoz9p7vK7vLxCdfOdRFmbfQ7GUd xaolan@Seraphine"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHhkSRUQLV7JpjtPdbFR8vXnJhLhSfbh3vL+j9v/5Bv/ xaolan@Aphrodite"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8XCGfozlovdRKSzI8mRL7Bkexk+GoK+WCTWxVmBmDA xaolan@Yunara"
    ];
  };

  hosts = {
    Ionia = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINZAm8+KGrsCGT7dJbz/Rcm18NslDLrYzzcgHZ4334aa"];
    Raphael = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILJFWrIy+ZoppWlZIG6qHrCfM9yChsKdW39iP5yPeBdl"];
    Seraphine = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2iNLNXkHv5CXeKy7zhR/bbJ/3SKjp/g/i6l09rjFdZ"];
    Aphrodite = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILfTXG9nFMbm3Gwkx+RT4ift402Q6sQiQrAKdl3lN3C5"];
    Yunara = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDva+u9uWAZJzU31JCGfV+uPCRbgGV+vsXUsHdk4lWkr"];
  };
in {
  "secret1.age".publicKeys = users.xaolan;
  "secret2.age".publicKeys = hosts.Ionia;
  "secret3.age".publicKeys = hosts.Raphael;
  "secret5.age".publicKeys = hosts.Seraphine;
  "secret6.age".publicKeys = users.xaolan;
  "secret8.age".publicKeys = hosts.Aphrodite;
  "secret9.age".publicKeys = hosts.Yunara;

  "bak_sak.age".publicKeys = users.xaolan;
  "mc_rcon.age".publicKeys = users.xaolan ++ hosts.Seraphine;
}
