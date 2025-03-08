#!/usr/bin/env bash

echo "installing plugins for 'yazi'"

if ! command -v yay 2>&1 >/dev/null; then
  echo "you need 'yay' to install pre-reqs"
  exit 1
fi

if ! command -v yazi 2>&1 >/dev/null; then
  echo "you need 'yazi' to install yazi plugins"
  exit 1
fi

ya pack -a "Reledia/hexyl"
ya pack -a "Reledia/glow"
ya pack -a "Sonico98/exifaudio"
ya pack -a "yazi-rs/plugins:chmod"

# ya pack cannot install these:

git clone https://github.com/Urie96/preview.yazi.git ~/.config/yazi/plugins/preview.yazi

## Pre-reqs: preview.yazi
yay -S --needed bat ffmpegthumbnailer unarchiver poppler perl-image-exiftool tree \
  glow imagemagick pandoc-bin sqlite smali miller android-tools transmission-cli catdoc docx2t woff2
