# dotfiles — Hyprland

Personal Hyprland dotfiles for Arch Linux. Themed with **Catppuccin Mocha** across all components.

---

## Components

| Component | Tool |
|---|---|
| Compositor | [Hyprland](https://hyprland.org) |
| Status bar | [Waybar](https://github.com/Alexays/Waybar) |
| App launcher | [Wofi](https://hg.sr.ht/~scoopta/wofi) |
| Terminal | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| Editor | [Neovim](https://neovim.io) |
| Wallpaper daemon | [awww](https://github.com/LGFae/swww) |
| Video wallpaper | [mpvpaper](https://github.com/GhostNaN/mpvpaper) *(optional)* |
| Bluetooth | [Blueman](https://github.com/blueman-project/blueman) |
| Audio | [PipeWire](https://pipewire.org) + [WirePlumber](https://pipewire.pages.freedesktop.org/wireplumber/) |
| System monitor | [btop](https://github.com/aristocratos/btop) |
| Audio visualizer | [cava](https://github.com/karlstav/cava) |
| Shell | Bash / Zsh |

---

## Requirements

Install all required packages before running the installer.

**Official repos:**
```bash
sudo pacman -S hyprland waybar wofi kitty neovim \
               awww grim slurp \
               pipewire wireplumber pavucontrol \
               blueman network-manager-applet \
               brightnessctl playerctl \
               btop cava \
               ttf-firacode-nerd ttf-font-awesome
```

**AUR (optional — video wallpapers):**
```bash
yay -S mpvpaper
```

---

## File Structure

```
dotfiles/
├── .bashrc
├── .zshrc
├── .bash_profile
├── .profile
├── .bash_aliases
│
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf               # Entry point — sources all modules
│   │   ├── hyprpaper.conf              # Archived (replaced by awww)
│   │   ├── conf_hyprland/
│   │   │   ├── env.conf                # Environment variables
│   │   │   ├── autostart.conf          # Startup programs
│   │   │   ├── look-and-feel.conf      # Appearance, animations, layouts
│   │   │   ├── input.conf              # Keyboard, mouse, touchpad
│   │   │   ├── keybinds.conf           # All keybindings
│   │   │   └── windowrules.conf        # Window & workspace rules
│   │   └── scripts/
│   │       └── wallpaper.sh            # Wallpaper manager (static/animated/video)
│   │
│   ├── waybar/
│   │   ├── config                      # Bar layout and module list
│   │   ├── modules.json                # Module definitions
│   │   ├── style.css                   # Imports all style modules
│   │   ├── styles/                     # Per-module CSS files
│   │   │   ├── base.css
│   │   │   ├── workspaces.css
│   │   │   ├── clock.css
│   │   │   ├── search.css
│   │   │   ├── audio.css
│   │   │   ├── bluetooth.css
│   │   │   ├── network.css
│   │   │   ├── battery.css
│   │   │   ├── hardware.css
│   │   │   ├── tray.css
│   │   │   ├── exit.css
│   │   │   └── tooltip.css
│   │   └── scripts/
│   │       ├── bluetooth-status.sh
│   │       └── powermenu/
│   │
│   ├── wofi/
│   │   ├── config
│   │   └── style.css
│   │
│   ├── kitty/kitty.conf
│   ├── nvim/
│   ├── btop/btop.conf
│   └── cava/config
│
├── wallpapers/
│   ├── static/                         # JPG, PNG  →  wp-static
│   ├── animated/                       # GIF       →  wp-animated
│   └── videos/                         # MP4, WebM, MKV  →  wp-video
│
├── install.sh
└── README.md
```

---

## Installation

**1. Clone the repository:**
```bash
git clone https://github.com/SirProg/dotfiles.git ~/dotfiles
```

**2. Run the installer:**
```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The installer creates symlinks from `~/.config/...` to the dotfiles repo. Any existing files are backed up to `~/.dotfiles-backup/<timestamp>/` before being replaced.

**3. Make the wallpaper script executable:**
```bash
chmod +x ~/.config/hypr/scripts/wallpaper.sh
```

**4. Log out and log back into Hyprland.**

---

## Wallpapers

Wallpapers are organized by type under `wallpapers/`. The script at `.config/hypr/scripts/wallpaper.sh` manages all three modes and is launched automatically on startup (static mode by default).

### Folder layout

| Folder | Format | Mode |
|---|---|---|
| `wallpapers/static/` | JPG, PNG | `wp-static` |
| `wallpapers/animated/` | GIF | `wp-animated` |
| `wallpapers/videos/` | MP4, WebM, MKV | `wp-video` *(requires mpvpaper)* |

### Switching modes

Use the shell aliases defined in `.bash_aliases`:

```bash
wp-static      # static images with fade transition (default)
wp-animated    # animated GIFs, auto-looped by awww
wp-video       # video wallpaper via mpvpaper
```

### Customizing transitions

Edit the variables at the top of `wallpaper.sh`:

```bash
INTERVAL=120              # seconds between wallpaper changes
TRANSITION_TYPE="fade"    # fade | wave | wipe | grow | outer | random
TRANSITION_DURATION="1.5" # transition length in seconds
TRANSITION_FPS="60"
```

---

## Keybindings

### Apps
| Keybind | Action |
|---|---|
| `Super + Q` | Open terminal (Kitty) |
| `Super + E` | Open file manager (Nautilus) |
| `Super + R` | Open app launcher (Wofi) |

### Window Management
| Keybind | Action |
|---|---|
| `Super + C` | Close focused window |
| `Super + Shift + C` | Force kill window (click to select) |
| `Super + V` | Toggle floating |
| `Super + P` | Toggle pseudotile *(dwindle)* |
| `Super + J` | Toggle split direction *(dwindle)* |
| `Super + M` | Exit Hyprland |

### Focus
| Keybind | Action |
|---|---|
| `Super + ←/→/↑/↓` | Move focus |

### Workspaces
| Keybind | Action |
|---|---|
| `Super + 1–0` | Switch to workspace |
| `Super + Shift + 1–0` | Move window to workspace |
| `Super + S` | Toggle scratchpad |
| `Super + Shift + S` | Move window to scratchpad |
| `Super + Scroll` | Cycle workspaces |

### Mouse
| Keybind | Action |
|---|---|
| `Super + LMB drag` | Move window |
| `Super + RMB drag` | Resize window |

### Screenshot
| Keybind | Action |
|---|---|
| `Super + Shift + S` | Region screenshot → saved to `~/Imágenes/Screenshots/` |

### Media & Hardware
| Keybind | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume +5% |
| `XF86AudioLowerVolume` | Volume -5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioMicMute` | Toggle mic mute |
| `XF86MonBrightnessUp` | Brightness +5% |
| `XF86MonBrightnessDown` | Brightness -5% |
| `XF86AudioPlay/Pause` | Play / Pause |
| `XF86AudioNext/Prev` | Next / Previous track |

### Keyboard Layout
Toggle between `us` and `latam` layouts: `Alt + Shift`

---

## Shell Aliases

Defined in `.bash_aliases`:

```bash
# Navigation
..          cd ..
...         cd ../..
mkdcd <dir> mkdir -p <dir> && cd <dir>

# Tools
nv          nvim
la          ls -a
lt          ls -t
li          ls -l
cls         clear
ex          exit

# Waybar
waybar-reload   restart waybar

# Wallpaper
wp-static       switch to static image mode
wp-animated     switch to animated GIF mode
wp-video        switch to video wallpaper mode
```

---

## Waybar Modules

| Module | Description |
|---|---|
| `hyprland/workspaces` | Active workspace indicator (left) |
| `clock` | Center clock |
| `custom/search` | Wofi launcher button |
| `pulseaudio` | Volume control → click opens pavucontrol |
| `custom/bluetooth` | Bluetooth status → click opens blueman |
| `tray` | System tray |
| `network` | WiFi / Ethernet status |
| `battery` | Battery level with states (good / warning / critical) |
| `group/hardware` | Drawer group containing disk usage |
| `custom/exit` | Power menu |

Each module has its own CSS file under `.config/waybar/styles/`.

---

## Notes

- `hyprpaper.conf` is kept in the repo but inactive — wallpapers are handled by `awww` via `wallpaper.sh`.
- The `awww` package in Arch repos is the successor to `swww` and is fully compatible.
- `mpvpaper` is only required for video wallpapers (`wp-video`). Static and animated modes work without it.
- Screenshots require `grim` and `slurp`.
