{
  inputs,
  outputs,
  libs,
  ...
}: {

  xdg.configFile = {
    alfred.source = ../../dotfiles/alfred;
    atuin.source = ../../dotfiles/atuin;
    bat.source = ../../dotfiles/bat;
    btop.source = ../../dotfiles/btop;
    toml.source = ../../dotfiles/config.toml;
    dunst.source = ../../dotfiles/dunst;
    fd.source = ../../dotfiles/fd;
    fish.source = ../../dotfiles/fish;
    gh.source = ../../dotfiles/gh;
    ghostty.source = ../../dotfiles/ghostty;
    htop.source = ../../dotfiles/htop;
    hypr.source = ../../dotfiles/hypr;
    neofetch.source = ../../dotfiles/neofetch;
    nvim.source = ../../dotfiles/nvim;
    rofi.source = ../../dotfiles/rofi;
    sketchybar.source = ../../dotfiles/sketchybar;
    skhd.source = ../../dotfiles/skhd;
    swaylock.source = ../../dotfiles/swaylock;
    waybar.source = ../../dotfiles/waybar;
    wezterm.source = ../../dotfiles/wezterm;
    wlogout.source = ../../dotfiles/wlogout;
    yabai.yabai.source = ../../dotfiles/yabai;
    yazi.source = ../../dotfiles/yazi;
  };

}
