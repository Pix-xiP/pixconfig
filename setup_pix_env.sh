#!/bin/bash

set -e # Exit on error

# Easy Colour printing!
SUCCUSS="$(tput setaf 2)[S]:$(tput sgr0)"
ERROR="$(tput setaf 1)[!]:$(tput sgr0)"
INFO="$(tput setaf 4)[+]:$(tput sgr0)"
WARN="$(tput setaf 3)[W]:$(tput sgr0)"
INPUT="$(tput setaf 6)[>]:$(tput sgr0)"
LOG="pix_install.log"

info() {
	printf "%s%s%s\n" "$INFO" "$1" "$NC"
}

success() {
	printf "%s%s%s\n" "$SUCCUSS" "$1" "$NC"
}

warn() {
	printf "%s%s%s\n" "$WARN" "$1" "$NC"
}

error() {
	printf "%s%s\n" "$ERROR" "$1" "$NC" >&2
}

printf "$INFO Running Pix's Arch Linux Hyprland and Development Environment Script\n"
sleep 2
printf "$WARN Please remember to backup your files if this isn't a fresh install! \nThis script will pave over your config files\n"
sleep 2
printf "$WARN Some commands require you to enter a password to execute, you may need to baby sit this script.\n"
printf "$WARN CTRL C or CTRL Q can quit this script if you need to!\n"
sleep 2

HAS_YAY=/sbin/yay

if [ -f "$HAS_YAY" ]; then
	printf "$INFO 'yay' was located, using it to install.\n"
else
	printf "$WARN Unable to locate 'yay' \n"
	read -n1 -rep "$INPUT Would you like to install [Y/n]" INST
	if [[ $INST =~ ^[Nn]$ ]]; then
		printf "$ERROR An AUR helper is required for this script, feel free to update to your AUR Helper of choice. Now exiting\n"
		exit 1
	else
		info "Installing YAY"
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si --noconfirm 2>&1 | tee -a $LOG
		cd ..
	fi
	# Update System now.
	printf "$INFO Updating system to avoid issues"
	yay -Sy archlinux-keyring --noconfirm 2>&1 | tee -a $LOG
	yay -Syu --noconfirm 2>&1 | tee -a $LOG
fi

### Install Packages ###
read -n1 -rep "${INPUT} Would you like to install packages? [Y/n]" INST
echo

if [[ $INST =~ ^[Nn]$ ]]; then
	warn "No packages installed. Ending Script"
	exit 1
else
	## Use Midori Browser but download from the side direct, the AUR is a full major version behind.
	GIT_PKGS="grimblast-git sddm-git hyprpicker-git waybar-hyprland-git"
	HYPR_PKGS="hyprland wl-clipboard wf-recorder rofi wlogout swaylock-effects dunst swaybg"
	FONT_PKGS="ttf-fira-code ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font otf-sora noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd adobe-source-code-pro-fonts"
	APP_PKGS="discord wg-look-bin qt5ct btop gvfs ffmpegthumbs swww mousepad mpv playerctl pamixer noise-suppression-for-voice polkit-gnome ffmpeg viewnior pavucontrol thunar ffmpegthumbnailer tumbler thunar-archive-plugin xdg-user-dirs"
	THEME_PKGS="nordic-theme papirus-icon-theme starship"
	DEV_PKGS="eza jq sd fd neovim duf dust trippy wezterm alacritty lazygit zerotier-one ripgrep pixz rsync croc axel bat btop curl meson go-task fish fzf go glow gum htop less lua navi neofetch tealdeer tokei vim unzip wget zoxide jujutsu rm-improved go"

	if ! yay -S --noconfirm $GIT_PKGS $HYPR_PKGS $FONT_PKGS $APP_PKGS $DEV_PKGS $THEME_PKGS 2>&1 | tee -a $LOG; then
		error "Failed to install additional packages - please check the install log\n"
		exit 1
	fi
	xdg-user-dirs-update
	success "All packages installed successfully!"
fi

### Config Files ###

read -n1 -rep "$INPUT Would you like to copy config files? [Y/n]" CFG
if [[ $CFG =~ ^[Nn]$ ]]; then
	info "Config files not installed"
else
	info "Copying configuration files into .config"
	# cp -r pixconfig/alacritty ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/dunst ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/fish ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/hypr ~/.config/ 2>&1 | tee -a $LOG
	# cp -r pixconfig/nvim ~/.config/ 2>&1 | tee -a $LOG
	# cp -r pixconfig/pipewire ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/rofi ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/swaylock ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/waybar ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/waybar ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/wezterm ~/.config/ 2>&1 | tee -a $LOG
	cp -r pixconfig/wlogout~/.config/ 2>&1 | tee -a $LOG

	# Set some files as executable!
	chmod +x ~/.config/hypr/xdg-portal-hyprland
	chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi

### Fonts for Waybar! ###
mkdir -p ./waybar-setup/nerdfonts
cd ./waybar-setup
axel -n 4 https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip
unzip '*.zip' -d ./nerdfonts
rm -rf *.zip
sudo cp -R ./nerdfonts/ /usr/share/fonts/

fc-cache -rv

read -n1 -rep 'Would you like to enable SDDM autologin [Y/n]' SDDM
if [[ $SDDM =~ ^[nN]$ ]]; then
	info "Not enabling auto login!"
else
	LOC="/etc/sddm.conf"
	info "Adding the following to $LOC"
	echo -e "[Autologin]\nUser = $(whoami)\nSession=hyprland" | sudo tee -a $LOC
	info "Enabling SDDM service..."
	sudo systemctl enable sddm
	sleep 3
fi

### Bluetooth ###
read -n1 -rep "$INPUT Optional! - Would you like to install bluetooth packages? [y/N]" BT
if [[ $BT =~ ^[yY]$ ]]; then
	info "Instaling Bluetooth Packages!..."
	BLUE_PKG="bluez bluez-utils blueman"
	if ! yay -S --noconfirm $BLUE_PKG 2>&1 | tee -a $LOG; then
		error "Failed to install bluetooth packages - please check the install log."
	else
		sudo systemctl enable --now bluetooth.service
		sleep 3
	fi
else
	info "Not installing bluetooth!"
fi

success "Installation Completed!"
read -n1 -rep "$INPUT Would you like to start Hyprland now? [Y/n]" HYPR
if [[ $HYPR =~ ^[Nn]$ ]]; then
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
