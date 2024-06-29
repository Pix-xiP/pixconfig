#!/bin/bash

set -e # Exit on error

LOG="pix_install.log"

if ! command -v gum log; then
	echo "Running quick bootstrap..."
	sudo pacman -Sy gum --noconfirm
	exit 1
fi

p() {
	gum log -t kitchen -s -l none "$1"
}

info() {
	gum log -t kitchen -s -l info "$1"
}

success() {
	gum log -t kitchen -s -l info --prefix="SUCCESS" "$1"
}

warn() {
	gum log -t kitchen -s -l warn "$1"
}

error() {
	gum log -t kitchen -s -l error "$1"
}

fatal() {
	gum log -t kitchen -s -l fatal "$1"
	exit 1
}

info "Running Pix's Arch Linux Hyprland and Development Environment Script\n"
sleep 1
warn "Please remember to backup your files if this isn't a fresh install! " \
	"\nThis script will pave over your config files\n"
sleep 1
warn "Some commands require you to enter a password to execute, you may need " \
	"to baby sit this script.\n"
warn "CTRL C or CTRL Q can quit this script if you need to!\n"
sleep 1

# TODO: Make a better yay check.
HAS_YAY=/sbin/yay
if [ -f "$HAS_YAY" ]; then
	info "'yay' was located, using it to install.\n"
else
	warn "Unable to locate 'yay' \n"
	p "Would you like to install?"
	USER_IN=$(gum input --placeholder "[Y/n]")
	if [[ $USER_IN =~ ^[Nn]$ ]]; then
		error "An AUR helper is required for this script, feel free to update to " \
			"your AUR Helper of choice. Now exiting\n"
		exit 1
	else
		info "Installing YAY"
		git clone https://aur.archlinux.org/yay.git | tee -a "$LOG"
		cd yay
		makepkg -si --noconfirm 2>&1 | tee -a "$LOG"
		cd ..
	fi
	# Update System now.
	info "Updating system to avoid issues"
	yay -Sy archlinux-keyring --noconfirm 2>&1 | tee -a $LOG
	yay -Syu --noconfirm 2>&1 | tee -a $LOG
fi
USER_IN=""

### Install Packages ###
p "Would you like to install packages?"
USER_IN=$(gum input --placeholder "[Y/n]")
if [[ $USER_IN =~ ^[Nn]$ ]]; then
	warn "No packages installed. Ending Script"
	exit 1
else

	# See the Toolset.MD for information.
	GIT_PKGS="grimblast-git sddm-git hyprpicker-git waybar-hyprland-git"

	HYPR_PKGS="hyprland hyprpaper wl-clipboard wf-recorder rofi wlogout swaylock-effects dunst swappy"

	FONT_PKGS="ttf-fira-code ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font otf-sora noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd adobe-source-code-pro-fonts"

	APP_PKGS="discord wg-look-bin qt5ct btop gvfs ffmpegthumbs swww mousepad mpv playerctl pamixer noise-suppression-for-voice polkit-gnome ffmpeg viewnior pavucontrol thunar ffmpegthumbnailer tumbler thunar-archive-plugin xdg-user-dirs"

	THEME_PKGS="nordic-theme papirus-icon-theme starship tree-sitter-cli tree-sitter rose-pine-cursor"

	TERM_PKGS="alacritty axel bat bear btop croc curl duf dust eza fastmod fd fish fzf glow go go-task gum htop jq jujutsu lazygit less lua meson navi neofetch neovim pixz procs ripgrep rm-improved rsync sd tealdeer tokei trippy unzip vim wezterm wget zerotier-one zoxide pacman-contrib"

	STREAMLINED_PKGS="axel bat bear croc curl duf dust eza fastmod fd fish fzf glow go gum htop jq lazygit less lua neovim pixz procs ripgrep rm-improved rsync tealdeer tokei trippy unzip vim wezterm wget zerotier-one zoxide pacman-contrib"

	if ! yay -S --noconfirm "$GIT_PKGS" "$HYPR_PKGS" "$FONT_PKGS" "$APP_PKGS" "$TERM_PKGS" "$THEME_PKGS" 2>&1 | tee -a "$LOG"; then
		error "Failed to install additional packages - please check the install log\n"
		exit 1
	fi
	xdg-user-dirs-update
	success "All packages installed successfully!"
fi
USER_IN=""

p "====================="
p "What would you like to do with config files?"
p "====================="
USER_IN=$(gum choose "Copy" "Symlink" "Skip")
if [[ $USER_IN == "Skip" ]]; then
	info "Skipping configuration files"
else
	if [[ $USER_IN == "Copy" ]]; then
		info "Copying configuration files into .config"
		cp -r pixconfig/* ~/.config/ 2>&1 | tee -a $LOG
	elif [[ $USER_IN == "Symlink" ]]; then
		# SYMLINK EXPERIMENT
		info "Symlinking config files"
		CUR=$(pwd)
		for f in ./pixconfig/*; do
			filename="${f##*/}"
			ln -b -s "$CUR/$f" ~/.config/"$filename" 2>&1 | tee -a $LOG
		done
	fi
	# Set some files as executable!
	chmod +x ~/.config/hypr/xdg-portal-hyprland
	chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi

### Fonts for Waybar! ###
mkdir -p ./waybar-setup/nerdfonts
cd ./waybar-setup || return
axel -n 4 https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip
unzip '*.zip' -d ./nerdfonts
rm -rf ./*.zip
sudo cp -R ./nerdfonts/ /usr/share/fonts/

fc-cache -rv

USER_IN=""
p "Would you like to enable SDDM autologin?"
USER_IN=$(gum input --placeholder "[Y/n]")
if [[ $USER_IN =~ ^[nN]$ ]]; then
	info "Not enabling auto login!"
else
	LOC="/etc/sddm.conf"
	info "Adding the following to $LOC"
	echo -e "[Autologin]\nUser = $(whoami)\nSession=hyprland" | sudo tee -a $LOC
	info "Enabling SDDM service..."
	sudo systemctl enable sddm
	sleep 3
fi
USER_IN=""

### Bluetooth ###
p "Optional! - Would you like to install bluetooth packages?"
USER_IN=$(gum input --placeholder "[y/N]")
if [[ $USER_IN =~ ^[yY]$ ]]; then
	info "Instaling Bluetooth Packages!..."
	BLUE_PKG="bluez bluez-utils blueman"
	if ! yay -S --noconfirm "$BLUE_PKG" 2>&1 | tee -a "$LOG"; then
		error "Failed to install bluetooth packages - please check the install log."
	else
		sudo systemctl enable --now bluetooth.service
		sleep 3
	fi
else
	info "Not installing bluetooth!"
fi

success "Installation Completed!"
USER_IN=""
p "Would you like to start Hyprland now?"
USER_IN=$(gum input --placeholder "[Y/n]")
if [[ $USER_IN =~ ^[Nn]$ ]]; then
	info "Finishing..."
	exit 0
else
	if command -v Hyprland >/dev/null; then
		exec Hyprland
	else
		error "Hyprland not found, please make sure Hyprland is installed after all this."
		exit 1
	fi
fi
