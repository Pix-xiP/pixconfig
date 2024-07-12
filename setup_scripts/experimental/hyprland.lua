require("logging")
require("sh")
local pkgs = require("pkgs")

local function file_exists(name)
	local f = io.open(name, "r")
	return f ~= nil and io.close(f)
end

-- ACTUAL SCRIPT RUNS HERE - Eventually move everything to functions?
info("Hello")

info("Running Pix's Experimental Lua setup script for Arch Linux")

warn("Please remember to backup your files if this isn't a fresh install!\n\tThis script will pave over config files")
warn("Some commands require a password to execute, you may need to babysit")

if file_exists("/sbin/yay") then
	success("'yay' was located! Using it to install packages")
else
	warn("Unable to locate 'yay'")
	print("Would you like to install yay? [Y/n]")
	local input = io.read(1)
	if input == "n" or input == "N" then
		fatal("An AUR helper is required for this script, update to an AUR helper of your choosing. Exiting")
	else
		info("Installing 'yay'")
		-- os.execute("git clone https://aur.archlinux.org/yay.git; cd yay; makepkg -si")
		git("clone https://aur.archlinux.org/yay.git; cd yay; makepkg -si")
	end
	info("Updating the system keyring to avoid any issues")
	-- os.execute("yay -Sy archlinux-keyring --noconfirm")
	-- os.execute("yay -Syu --noconfirm")
	yay("-Sy archlinux-keyring --noconfirm")
	yay("-Syu --noconfirm")
end

-- TODO: Allow for selecting of packages instead of hardcoded.
-- print("Please select what packages you would like to install")
-- for k, v in pairs(pkgs) do
-- 	print("====================", k, "===================")
-- 	-- for kk, vv in pairs(v) do
-- 	-- 	-- print(kk)
-- 	-- 	print(vv)
-- 	-- end
-- end

-- Update our dirs.
os.execute("xdg-user-dirs-update")
success("All packages installed successfully!")

info("=====================")
info("What would you like to do with config files?")
info("=====================")

print("\n1 - Symlink\n2 - Copy\n3 - Skip")
local input = io.read(1)
if input == 1 then
	local dfiles = tostring(ls())
	for f in dfiles do
		local sym = string.format("-b -s ./dotfiles/%s ~/.config/%s", f, f)
		ln(sym)
	end
elseif input == 2 then
	cp("-r pixconfig/* ~/.config/")
end

if file_exists("~/.config/hypr/xdg-portal-hyprland") then
	chmod("+x ~/.config/hypr/xdg-portal-hyprland")
end
if file_exists("~/.config/waybar/scripts/waybar-wttr.py") then
	chmod("+x ~/.config/waybar/scripts/waybar-wttr.py")
end

mkdir("-p ./waybar-setup/nerdfonts")
axel(
	"-n 4 https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip -o ./waybar-setup/CascadiaCode.zip"
)
unzip("*.zip -d ./nerdfonts")
rm("-rf ./CascadiaCode.zip")
sudo("cp -R ./nerdfonts/ /usr/share/fonts/")

os.execute("fc-cache -rv")
