{
  self,
  inputs,
  ...
}: {
  imports = [
    ./specialisations.nix
    ./terminal
    ./theme/stylix.nix
    inputs.nix-index-db.hmModules.nix-index
    inputs.tailray.homeManagerModules.default
    self.nixosModules.theme
  ];

  home = {
    username = "xaolan";
    homeDirectory = "/home/xaolan";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "devdoc"];
    shell.enableFishIntegration = true;
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
