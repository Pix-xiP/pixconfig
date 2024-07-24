# Configures the System environment
# This should replace `/etc/nixos/configuration.nix`

{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {

  # Optionally import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    ## PIXNOTE:
    ## This should be specific to ever build, if using my bootstrap script, this should 
    ## be in this location and useable.
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader:
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  ## PIXNOTE: 
  ## On QEMU on Mac, this will need updating to `/dev/vda`
  boot.loader.grub.device = "/dev/sda";

  nixpkgs = {
    # You can add overlays here!
    overlays = [
      outputs.overlays.unstable-packages 
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure the nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = let 
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command 
      ### Means you don't have to do the dumb --experimental etc etc
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  ## Whomst the fudge are you?
  networking.hostName = "nier";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  ## Add local bin to path
  environment.localBinInPath = true;

  ## Open poats in the Firewall:
  ### PIXTODO: Sus out what to have open on a more secure system.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  i18n.defaultLocal = "en_US.UTF-8";

  ## Timezone
  time.timeZone = "Australia/Perth";

  ### TODO: Is this, system uses fish? Should be zsh?.. CHECKER
  programs.fish.enable = true;

  users.users = {
    pix = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      packages = with pkgs; [
        ## Packages not going to be handled from Home-manaeger?
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
        dig
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
        git 
        gitleaks
        gitui
        glow
        gnupg
        go
        go-task
        gum
        hexyl
        hiredis
        home-manager
        hping
        htop
        hyperfine
        hyprland
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
        vim
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
      ]

    };
  };

  ## Fonts 
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerdfonts
      maple-font
    ];

    fontconfig = {
      defaultFonts = {
        ## PIXTODO: Sus out which fonts I do actually wanna use? Maple Mono perhaps?
        serif = [ "SF Pro" ]
        sansSerif = [ "SF Pro" ]
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };

  ## Sytlix Set base16 bby?
  stylix = {
    base16Scheme = {
      ## TODO: Update to RosePine or Shado
  		base00 = "1e1e2e"; # base
      base01 = "181825"; # mantle
      base02 = "313244"; # surface0
      base03 = "45475a"; # surface1
      base04 = "585b70"; # surface2
      base05 = "cdd6f4"; # text
      base06 = "f5e0dc"; # rosewater
      base07 = "b4befe"; # lavender
      base08 = "f38ba8"; # red
      base09 = "fab387"; # peach
      base0A = "f9e2af"; # yellow
      base0B = "a6e3a1"; # green
      base0C = "94e2d5"; # teal
      base0D = "89b4fa"; # blue
      base0E = "cba6f7"; # mauve
      base0F = "f2cdcd"; # flamingo
    };
    image = "";
    polarity = "dark";
    cursor = {
      package = pkgs.google-cursor;
      name = "GoogleDot-Black";
      size = 14;
    };
  };

  ## Enable Wayland? TODO:
  services.wayland = {

  }
  
  ## Hyrland?
  programs.hyprland.enable = true;
  programs.hyrland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;



}
