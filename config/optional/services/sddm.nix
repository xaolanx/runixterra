{
  pkgs,
  inputs',
  ...
}: let
   sddm-theme = inputs'.silentSDDM.packages.default;
in  {
   environment.systemPackages = [sddm-theme sddm-theme.test];
   qt.enable = true;
   services.displayManager.sddm = {
      package = pkgs.kdePackages.sddm;
      enable = true;
      theme = sddm-theme.pname;
        wayland.enable = true;      
      extraPackages = sddm-theme.propagatedBuildInputs;
      settings.Theme.CursorSize = 24;
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
   };
}
