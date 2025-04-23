#!/usr/bin/bash

echo "Bootstrappin an Arch container"

set -e
set -x

trust extract-compat

cat <<EOF >/etc/pacman.d/mirrorlist
Server = https://mirror.aarnet.edu.au/pub/archlinux/\$repo/os/\$arch
Server = http://archlinux.mirror.digitalpacific.com.au/\$repo/os/\$arch
Server = https://archlinux.mirror.digitalpacific.com.au/\$repo/os/\$arch
Server = http://ftp.iinet.net.au/pub/archlinux/\$repo/os/\$arch
Server = http://mirror.internode.on.net/pub/archlinux/\$repo/os/\$arch
Server = http://mirror.launtel.net.au/repo/arch/\$repo/os/\$arch
Server = https://mirror.launtel.net.au/repo/arch/\$repo/os/\$arch
Server = http://arch.lucassymons.net/\$repo/os/\$arch
Server = https://arch.lucassymons.net/\$repo/os/\$arch
Server = http://syd.mirror.rackspace.com/archlinux/\$repo/os/\$arch
Server = https://syd.mirror.rackspace.com/archlinux/\$repo/os/\$arch
Server = http://ftp.swin.edu.au/archlinux/\$repo/os/\$arch
EOF

pacman-key --init
pacman-key --populate archlinux

pacman -Sy archlinux-keyring --noconfirm

pacman -Syyu --noconfirm

pacman -Sy sudo git vim --noconfirm

echo "Do you need yay? [y/N]"
read -r Y_N

if [[ $Y_N == "y" ]] || [[ $Y_N == "Y" ]]; then

  pacman -Sy base-devel --noconfirm

  git clone https://aur.archlinux.org/yay-git

  useradd -m admin

  mv yay-git /home/admin/yay

  chown -R admin:admin /home/admin/yay

  echo "admin ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers

  cd /home/admin/yay

  su admin -c "makepkg -si --noconfirm"

  yay -Sy yay --noconfirm

  rm -rf /home/admin/yay
fi
