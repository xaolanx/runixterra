let
  ionia = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBObAgwEBXSC0NBNtsRrXCTUOu95PvkqlRhyr6R6bOQJ root@ionia";
  yunara = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFr0RB1XXBJjCZHvKPzBa4IJGxxPmAAUv1lNtmYMbo9 xaolan@yunara";
in {
  "nix-access-tokens-github.age".publicKeys = [ionia yunara];
}
