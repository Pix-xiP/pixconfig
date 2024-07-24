# Home manager Configuration File!
# Configure home files
# It replaces ~/.config/nixpkgs/home.nix

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Other home-manager modules here
  imports = [
    # Can put other files here and other imports 
    # ../../potato/files
    ../../modules
  ];

  home = {
    username = "pix";
    homeDirectory = "/home/pix";
    pointerCursor = {
      package = pkgs.google-cursor;
      name = "GoogleDot-Black";
      size = 14;
    };
    sessionVariables = {
      EDITOR = "nvim";
      PIXCONFIG = "/home/pix/AdeptusCustodes/pixconfig"
    };
    stateVersion = "24.05";
  };

  # XDG Portals
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  # Security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  # Services
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "colemak";
      excludePackages = [ pkgs.xterm ];
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    ## Maybe drop this.
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
  };  

programs = {
    hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland.enable = true;
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };


    ### TODO: Split this into system packages and user :>
  home.packages = with pkgs; [
    # pkgs.surrealdb # The install on this takes years just use brew..
    angle-grinder
    atuin
    axel
    bandwhich
    bat
    bear
    bitwise
    btop
    choose
    cmake
    croc
    ctop
    curlie
    darwin.iproute2mac
    delta
    dogdns
    dos2unix
    dotnet-sdk_8
    doxygen
    duf
    dust
    eza
    fastmod
    fd
    fish
    fzf
    fzy
    getopt
    gh
    gitleaks
    gitui
    glow
    gnupg
    go
    go-task
    gum
    hexyl
    hiredis
    hping
    htop
    hyperfine
    icdiff
    jemalloc
    jq
    jujutsu
    lazydocker
    lazygit
    lnav
    lua
    meson
    mimalloc
    mutt
    navi
    neofetch
    neovide
    neovim
    ninja
    nmap
    # nodejs_21 ??? Errors even though its in the search.nix pkgs?
    noti
    nowplaying-cli
    nushell
    onefetch
    p7zip
    pandoc
    pingme
    pixz
    procs
    pueue
    python312
    qemu
    rclone
    ripgrep
    ripgrep-all
    rm-improved
    rsync
    rustc
    rustup
    sad
    sd 
    shellcheck
    sketchybar
    sqlite
    swift-format
    tart
    tcpdump
    tcpreplay
    tealdeer
    tigervnc
    tokei
    tree-sitter
    trippy
    wget
    wtf
    xz
    yq
    zoxide
    zstd

## GUIS
    alacritty
    docker
    flameshot
    # pkgs.hammerspoon # Cannot be done?
    keepassxc
    # heaptrack # Pending merge from emily <3
    meld
    rectangle
    # pkgs.sublime-merge # Stopped using
    # pkgs.shotcut # Pending Darwin Allowed.
    wezterm
    yabai
    # pkgs.zerotierone # Pending Darwin Allowed.

## Libraries
    libevent
    libpcap
    libuv

## Fonts?
    nerdfonts

# MISSING:
    #pkgs.svim
  ];


  programs.home-manager.enable = true;

  system.user.startServices = "sd-switch";
}
