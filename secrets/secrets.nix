let
  ionia = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHKEPlN/GU9nJZPleA77HH5NA+6vyhhM84fTSjEwnEgq xaolan@ionia";
  yunara = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZjHWTqLOqwSWwv2XRNqRoflnJ0UoIB2SMvkBfdQFKM xaolan@Yunara";
in {
  "nix-access-tokens-github.age".publicKeys = [ionia yunara];
}
