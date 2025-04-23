local software = require("software")

print("lets install some setups \\o/")

print([[
Which setup do you want to install?
  1. Hyprland
  2. Niri
  3. Base (just the basics)
  ]])
local choice = io.read("*n")

local data = {}

if choice == 1 then
	print("installing 'Hyprland' setup")
	print("software", software)
	for k, v in pairs(software) do
		print(k, v)
	end

	data = software.get_software("hyprland")
elseif choice == 2 then
	print("installing 'Niri' setup")
	data = software.get_software("niri")
elseif choice == 3 then
	print("installing just the basics!")
	data = software.get_software("base")
else
	print("Invalid option, closing.")
	os.exit(1)
end

local install_str = "yay -Sy --noconfirm"
for _, pkg in pairs(data.pkgs) do
	install_str = install_str .. " " .. pkg
end

print("install str\n" .. install_str)
-- os.execute(install_str)
