local home_dir = os.getenv("HOME")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("MOZ_ENABLE_WAYLAND", 1)
hl.env("GDK_SCALE", 1)
hl.env("PIXCONFIG", home_dir .. "/AdeptusCustodes/pixconfig")
hl.env("XCURSOR_SIZE", 20)
hl.env("GSK_RENDERER", "gl")
