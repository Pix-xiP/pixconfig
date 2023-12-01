# Pix's Tool List 

-----------------
This is like a compilation of stuff I've found that I use regularly or have 
for niche occasions along with some alternatives I've tried that you might find
useful that I personally didn't vibe with.

When the list has conflicting things that do the same, the closer to the top one is 
usually what I'm using, though I haven't made that a strict rule, there is alot of 
shit here.. lmao

-----------------

### Colourscheme:
- Catpuccin Mocha
- Tokyonight
- Dracula

### Window Managers:
- Hyprland (Hybrid Tiling Floating.)
- Yabai (Hybrid Tiling Floating.)

### GUI Stuff
- `waybar`
Utility Bar to fill with whatever on wayland.
- `rofi`
Launcher for programs and files
- `wl-clipboard-history`
Clipboard History on GUI
- `swaybg`
Backgrounds!
- `swaylock`
Lock your PC
- `grim`
Screenshots
- `grimblast`
Screenshot Utility specifically for Hyprland.
`sddm`
Simple Desktop Display Manager - use for login etc.
`hyprpicker`
Pick out colours easily!
`waybar-hyprland` `(-git)`
Specific Waybar implementation for Hyprland.
`hyprpaper`
Wallpapers on Hyprland!
- `wl-clipboard`
Clipboard manager for wayland!
- `shotcut`
Free video editing software similar to after effects.
- `Alfred`
Replacement for spotlight on crack for Mac.
- `Raycast`
Replacement for spotlight, commercially developed not community based
- `ganttproject`
An old school gantt project manager that still works well today.
- `docker`
Docker Desktop, for when you cbf writing docker run .....
- `rectangle`
On top window manager that lets you snap to sides, corners, etc.
- `obsidian`
Markdown editor and renderer - decent for notes.
- `bitwarden`
Modern secure password vault / manager.
- `keepassx`
Older password vault, probably just use bitwarden.
- `tiger-vnc`
Decent VNC client for when you need GUI remote access.
- `skhd`
Simple Hotkey Daemon, map any key to anything.
- `sketchybar`
Useful information in a bar along the top, uses bash scripts to extend.
- `cleanshot x` | `flameshot`
Improved Screenshotting capabilities

### Fonts
	"ttf-fira-code ttf-nerd-fonts-symbols-common otf-firamono-nerd inter-font otf-sora " \
		"noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd adobe-source-code-pro-fonts"


### Shells:
- `fish`
  - Tide configuration
  - Fisherman package manager
    - My List:
      jorgebucaran/fisher        # Package manager
      decors/fish-colored-man    # Coloured man pages  
      danhper/fish-ssh-agent     # SSH agent using fish.
      jorgebucaran/autopair.fish # Auto [] {} () etc.
      catppuccin/fish            # Pastel theme (mocha)
      ilancosman/tide@v6         # Async modern shell prompt.
      patrickF1/fzf.fish         # FZF with hotkeys for fish.
      meaningful-ooo/sponge      # Cleans up typos from history
- `zsh`
- Warp (Mac only, proprietary...)

### Markdown:
Viewers:
- `glow`
- `gum format | pager`

### Editors:
- `neovim`
  - `LazyVim`: Easy bootstrapper, I run a customised version of this.
    Extras I add:
      - Fish Plugin and Parser
      - LLM integration via LM Studio && Codeium
      - Customised LSP servers 
      - Custom styles for nvim via nvim.lua / nvim.style in folder roots.
      - Redone keymapping cause `Colemak` keyboard
      - Extra treesitter files for languages like `odin` and `zig` 
      - Custom formatters for C and Swift.
- `Sublime Text`
  Running a custom theme I made on MacOS.
- `Zed`
- Interesting editor written in Rust, comes with built in LSP support.

### Terminals:
- `wezterm`
- `foot`
- `st`
- `alacritty`
- `iterm2`


### File Conversion:
1. Swiss army knives:
- `pandoc`: swiss army knife for docs
- `ffmpeg`: swiss army knife for video 
- `sox`   : swiss army knife for audio 

### File Listing and Searching:
- `zoxide`
A replacement for `cd`, faster, more options.
- `eza` (`exa` is deprecated)
A replacement for `ls` with more options available.
- `bat`
`cat` but with color and stuff
- `dust`
`du` but better and faster.
- `duf`
`df` but better and faster.
- `ripgrep`
`grep` but way faster
- `fzf`
A fast and good fuzzy finder.
- `rsync`
`cp` / `scp` replacement, often faster when copying repeatedly
- `xcp`
Beta improvement on cp - mostly linux focused.
- `rclone`
Sync files and folders with various cloud providers
- `dd`
Disk management, `cp` replacement, disk utility Warning: Dangerous.
- `icdiff`
Smarter `diff` with colour and dual layouts, easier to read.
- `jq`
Json terminal formatter, very very useful
- `croc`
Easily and securely send any file from computer to computer.
- `tokei`
Keeps track of the lines of code written in a project
- `delta`
Smarter `diff` with colour, dual layouts and closer to Sublime Merge style
- `rip` && `rm-improved`
A safer, more error friendly `rm`, allows for a graveyard.
- `fd`
Better `find`, easier syntax, generally faster.
- `sd`
Better `sed`, easier syntax
- `hunspell`
Check the spelling of a file given an encoding.

### Network Utilities:
- `netcat`
The network swiss army knife
- `tcpdump`
best way to view your network data in command line
- `trippy`
A network diagnostics tool
`bmon`
A network monitoring tool!
- `zerotier-one`
Build your own network anywhere, connect to anything.
- `axel`
Download anything at the speed of crack.
- `dog`
Better `dig`!
- `hping3`
Would you like to DOS something? Wanna do it again?
- `unbound`
recursive, validating and caching dns resolver (daemon version)

### General Utilities CLI
- `tealdeer | tldr`
`man` but a quick and dirty version
- `pixz`
parallised `xz` so its faster.
- `task` || `go-task`
A helpful CI tool for creating pipelines and auto builds.
- `curl cheat.sh/<thing>`
A helpful cheatsheet about a topic, usually web tool related.
- `procs`
A better, coloured and more easily searched `ps`
- `fastmod`
For making large codebase changes across multiple files at once.
- `botan`
Cryptographic CLI tool for generating all sorts of fun.
- `brotli`
Compression and Decompression package. (Think tar kinda)
- `mutt`
Email! But in your terminal!
- `navi`
Quick Cheatsheets that let you autofill commands and run them.
- `neofetch`
Show information about your computer.
- `nettle`
Hashing CLI tool.
- `npm, pnpm, yarn, bun, etc..`
The Javascript ecosystem...
- `choose`
TUI style option picker, good for interactive scripts. ( Replacement for cut)
- `flex`
Program for generating scanners for lexical pattern matching faster.
- `gd`
Bunch of cli tools for graphic manipulation.
- `glances`
Kind of like a way more advance `top`
- `htop` || `btop`
Better versions of top that keep its general concepts + extra
- `gperf`
Generates 'perfect' hash functions.
- `grex`
Generates regex based on a user test case, hit and miss imo.
- `hyperfine`
benchmarks stuff based on conditions you pick and generate.
- `iproute2mac`
`ip` commands on your mac, not all, but enough to make it comfy.
- `7zip`
Easy zip of files for people who dunno how to use tar.
- `shellcheck`
Make sure your scripts are written efficiently and without obvious pitfalls
- `xxhash`
hehe, hash go brrrr
- `xz`
Heavy compression tool, usually results in very small output
- `zstd`
Competes with `xz` for compression, but always has faster Decompression
- `gzip`
Faster compression tool, but will not result in as small of a output.
- `bear`
Generates compile_commands.json files for ClandD and some other LSPs

### Package Managers:
- `yay` (Arch)
Pacman standin for AUR written in Go.
- `paru` (Arch)
Pacman standin for AUR with features, written in Rust
- `brew` (All)
General purpose but slower package manager written in Ruby

### Version Control:
- `lazygit`
TUI style git client.
- `jujutsu` || `jj`
Combines the features of git, mercurial and extras into one system.
- `gitui`
TUI style git client - faster then lazygit according to benchmarks with less crashes
- `svn`
Mercurial based version control system
- `gh`
Interact specifically with github, makes pr and stuff much quicker then by hand.
- `git-flow`
Way overengineered form of git management with branches out the wazoo.
- `git-leaks`
Looks through repos for obvious leaks like passwords or creds or api-keys
#### Version Management (GUI)
- `Sublime Merge`
Fantastic git manager, makes merges very simple
- `git-kraken`
Alternative to the above, preference thing.

### Build Systems:
- `meson`
Easier Cmake using ninja as a backend.
- `cmake`
The better version of make, though its a pain
- `ninja`
Cmake replacement build system.
- `zig`
Turns out zig builds compiler is actually pretty fancy 

### Development Libraries
- `libevent`
Heard you wanted massive async socket connections.
- `libconfig`
Standardised C config reader
- `hiredis`
Redis in your C what joy
- `coreutils`
Standard C building blocks, you should know / use these.
- `xxhash`
hehe, hash go brrrr

### Languages
- `C`
Need I say more.
- `Odin`
C with QoL out of the box and less ambiguous behaviour
- `zig`
Replacement for C, faster in some cases, uses some wild new ideas.
- `go`
Gotta go fast boi, but fr, its great for CLI tools.
- `Swift`
Apples dynamic everything GPL. Cross compat with C. 
- `C++`
You know, C with extra bloat.
- `Python`
For when you just really need to script something 
- `bash`
Yes its a language, bite me. Get good at it. 
- `fish`
Like bash, but if you use that shell, handy to know. 
- `C#`
Access to the dotnet environment can be nice, but its basically better Java
- `perl` || `raku`
If you really just need to golf something.. 
- `lua`
Configuration for `neovim` and `wezterm`, small scripting language with `C` integration.
- `haskell`
Cause everyone needs to try functional programming at least once. Good for large scale text manipulation.



