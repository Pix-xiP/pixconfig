-- hyprland is the software I want brought along by default
-- most commonly on my hyprland systems.
local base = require("packages.base")

local pkgs = {}

local lists = {
	system = {
		"NetworkManager",
		"blueman",
		"bluez",
		"bluez-utils",
		"brightnessctl",
		"dunst",
		"ffmpeg",
		"gst-plugin-pipewire",
		"network-manager-applet",
		"pamixer",
		"pavucontrol",
		"pipewire",
		"pipewire-alsa",
		"pipewire-audio",
		"pipewire-jack",
		"pipewirk-pulse",
		"playerctl",
		"udiskie",
		"wireplumber",
	},
	display = {
		"cliphist",
		"dunst",
		"grimblast-git",
		"hyprland",
		"hyprpaper",
		"hyprpicker",
		"qt5-graphicaleffects",
		"qt5-quickcontrols",
		"qt5-quickcontrolsv2",
		"rofi-wayland",
		"sddm",
		"slurp",
		"swappy",
		"swaylock",
		"swaylock-effects-git",
		"swww",
		"waybar",
		"wlogout",
	},
	apps = {
		"discord",
		"dolphin",
		"gamemode",
		"mangohud",
		"steam",
		"zen-browser-bin",
	},
	theming = {
		"hyde-cli-git", -- hyde theme config tool
		"kvantum", -- svg based qt6 theme engine
		"kvantum-qt5", -- svg based qt5 theme engine
		"nwg-look", -- gtk config tool
		"qt5-wayland", -- wayland support in qt5
		"qt5ct", -- qt5 config tool
		"qt6-wayland", -- wayland support in qt6
		"qt6ct", -- qt6 config tool
	},
	dependencies = {
		"ffmpedthumbs", -- dolpthin video thumnails
		"imagemagick", -- image processing
		"kde-cli-tools", -- dolphin file type defaults
		"libnotify", -- notifications
		"pacman-contrib", -- sys update check
		"parallel", -- parallel processing
		"polkit-gnome", -- auth agent
		"qt5-imageformats", -- dolphin image thumbnails
		"xdg-desktop-portal-hyprland", -- xdg port for hyprland to x11
	},
}

-- Append the base packages
for k, v in pairs(base) do
	pkgs[k] = v
end

-- consolidate package lists
for _, v in pairs(lists) do
	for k, vv in pairs(v) do
		pkgs[k] = v
	end
end

print("----------")
for k, v in pairs(pkgs) do
	print(k, v)
end
print("----------")

-- return packages
return pkgs
