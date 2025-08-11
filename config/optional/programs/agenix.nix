{
  pkgs,
  config,
  pins,
  ...
}: {
  environment.systemPackages = [(pkgs.callPackage "${pins.agenix}/pkgs/agenix.nix" {})];
  imports = [(pins.agenix + "/modules/age.nix")];
  age.identityPaths = ["${config.hj.directory}/.ssh/id_ed25519"];
  # SSH keys are stored in user's home. So make sure home dir is mounted to access them at boot
  fileSystems."/home".neededForBoot = true;
}
