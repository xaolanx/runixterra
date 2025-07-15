{sources, ...}: {
  ".config/foot/rose-pine.ini".source = sources.foot + "/rose-pine";
  ".config/foot/foot.ini".text = ''
    [main]
    gamma-correct-blending=false
    dpi-aware=yes
    initial-window-mode=maximized
    font=Aporetic Serif Mono:size=11
    font-bold=Aporetic Serif Mono:weight=bold:size=12
    font-bold-italic=Aporetic Serif Mono Italic:weight=bold:slant=italic:size=12
    font-italic=Aporetic Serif Mono Italic:slant=italic:size=11
    pad=5x5 center
    include=~/.config/foot/rose-pine.ini

    [security]
    osc52=enabled

    [scrollback]
    lines=2000
    multiplier=2.0
    indicator-format=line

    [cursor]
    unfocused-style=hollow
    blink=yes

    [mouse]
    hide-when-typing=true

    [key-bindings]
    search-start=Control+Shift+f

    [colors]
    alpha = 0.79
  '';
}
