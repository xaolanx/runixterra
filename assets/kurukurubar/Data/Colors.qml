pragma Singleton
import Quickshell
import QtQuick

import Quickshell
import QtQuick

Singleton {
  // Ayu Dark (base24) Remapped Colors
  readonly property color background: "#0f1419"       // base00
  readonly property color error: "#ff3333"           // base08
  readonly property color error_container: "#7f1919"  // base0F
  readonly property color inverse_on_surface: "#323232" // base02
  readonly property color inverse_primary: "#36a3d9"  // base0D
  readonly property color inverse_surface: "#cbcbcb"  // base05
  readonly property color on_background: "#cbcbcb"    // base05
  readonly property color on_error: "#0f1419"        // base00
  readonly property color on_error_container: "#ff6565" // base12
  readonly property color on_primary: "#0f1419"      // base00
  readonly property color on_primary_container: "#68d5ff" // base0A/16
  readonly property color on_primary_fixed: "#212121" // base10
  readonly property color on_primary_fixed_variant: "#1a6a8f" // Darker variant of base0D
  readonly property color on_secondary: "#0f1419"    // base00
  readonly property color on_secondary_container: "#b8cc52" // base0B
  readonly property color on_secondary_fixed: "#212121" // base10
  readonly property color on_secondary_fixed_variant: "#95e6cb" // base0C
  readonly property color on_surface: "#cbcbcb"      // base05
  readonly property color on_surface_variant: "#989898" // base04
  readonly property color on_tertiary: "#0f1419"    // base00
  readonly property color on_tertiary_container: "#f07178" // base0E
  readonly property color on_tertiary_fixed: "#212121" // base10
  readonly property color on_tertiary_fixed_variant: "#e7c547" // base09
  readonly property color outline: "#656565"        // base03
  readonly property color outline_variant: "#323232" // base02
  readonly property color primary: "#68d5ff"        // base0A/16
  readonly property color primary_container: "#1a6a8f" // Darker variant of base0D (#36a3d9 → 20% darker)
  readonly property color primary_fixed: "#68d5ff"  // base0A/16
  readonly property color primary_fixed_dim: "#1a6a8f" // Matches primary_container
  readonly property color scrim: "#000000"          // base01
  readonly property color secondary: "#c2c5dd"      // (Retained)
  readonly property color secondary_container: "#424659" // (Retained)
  readonly property color secondary_fixed: "#dee1f9" // (Retained)
  readonly property color secondary_fixed_dim: "#c2c5dd" // (Retained)
  readonly property color shadow: "#000000"        // base01
  readonly property color surface: "#0f1419"       // base00
  readonly property color surface_bright: "#212121" // base10
  readonly property color surface_container: "#1e1f25" // (Closest: base11 #101010)
  readonly property color surface_container_high: "#292a2f" // (Closest: base02 #323232)
  readonly property color surface_container_highest: "#34343a" // (Closest: base02 #323232)
  readonly property color surface_container_low: "#1a1b21" // (Closest: base01 #000000)
  readonly property color surface_container_lowest: "#0d0e13" // (Closest: base01 #000000)
  readonly property color surface_dim: "#0f1419"   // base00
  readonly property color surface_tint: "#68d5ff"  // base0A/16
  readonly property color tertiary: "#f07178"      // base0E
  readonly property color tertiary_container: "#5b3d57" // (Retained)
  readonly property color tertiary_fixed: "#ffa3aa" // base17
  readonly property color tertiary_fixed_dim: "#f07178" // base0E

  function withAlpha(color: color, alpha: real): color {
    return Qt.rgba(color.r, color.g, color.b, alpha);
  }
}
