# Cyfraka’s NixOS Configuration

This repository contains my personal NixOS system and user (Home Manager) configuration files, designed for my ThinkPad X1 Carbon. It leverages Nix Flakes and Home Manager for reproducible, declarative system setup.

## Features

- **System Configuration**:  
  - Full system settings in `configuration.nix`
  - GNOME desktop with custom keybindings
  - Networking via NetworkManager
  - Pipewire audio, CUPS printing, and locale for Europe/Warsaw
  - Common packages: `vim`, `kitty`, `git`, `gnome-boxes`, `tmux`, `wget`, `fastfetch`, `signal-desktop`, `discord`
  - Automatic garbage collection and unfree package support

- **Hardware Configuration**:  
  - Managed by `hardware-configuration.nix`
  - LUKS disk encryption and hardware-specific settings

- **Home Manager**:  
  - User environment in `home.nix`
  - Custom GNOME wallpaper and keybindings
  - Vim, Kitty, Tmux, Git, and Bash configuration
  - Session variables, dotfiles, and Home Manager self-management

- **Nix Flakes Support**:  
  - `flake.nix` and `flake.lock` for reproducibility
  - Defines both system and user environments

## Directory Structure

```
.
├── configuration.nix           # Main NixOS system configuration
├── hardware-configuration.nix  # Auto-generated hardware config
├── home.nix                    # Home Manager user config
├── flake.nix                   # Nix Flake definition
├── flake.lock                  # Flake lock file (pin versions)
├── README.md                   # This file
├── 80s.jpg, Cyfraka.jpg        # Wallpaper and images
```

## Getting Started

### Prerequisites

- NixOS installed (preferably latest stable)
- Nix with experimental features: flakes

### Usage

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Cyfraka/NixOS.git
   cd NixOS
   ```

2. **Switch to your configuration (with flakes):**
   ```sh
   sudo nixos-rebuild switch --flake .#ThinkPad-X1-Carbon
   ```

3. **For Home Manager:**
   ```sh
   nix run home-manager/master -- switch --flake .#cyfraka
   ```

### Customization

- Edit `configuration.nix` for system-wide changes.
- Edit `home.nix` for user-specific (Home Manager) configuration.
- Update images or dotfiles as needed.

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)

## License

This repo is licensed under the [MIT License](https://github.com/NixOS/nixpkgs/blob/master/COPYING).
