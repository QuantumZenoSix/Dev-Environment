
My entire dev environment setup via one command.  

```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/utils/start.sh -O -)"
```

{IMAGE OF DROPDOWN HERE}  

<br />

_Note: This is designed for Arch Linux and Arch-based distros though I've done some work on the debian side as well._


<br />

__What each option gives you__


| Option            | Base Applications   | Configuration files  | Neovim Config  | Desktop apps | Gaming tools + enchancements        |
| ---               | ---                 | ---                  | ---            | ---          | ---                                 |
| CLI - All         | ✅                 | ✅                   | ✅            | ❌           | ❌                                  |
| CLI - Apps        | ✅                 | ❌                   | ❌            | ❌           | ❌                                  |
| CLI - Dotfiles    | ❌                 | ✅                   | ✅            | ❌           | ❌                                  |
| CLI - Nvim Config | ✅                 | ❌                   | ❌            | ❌           | ❌                                  |
| DSK - Pop! OS     | ✅                 | ✅                   | ✅            | ✅           | ✅                                  |
| DSK - Cachy OS    | ✅                 | ✅                   | ✅            | ✅           | ✅                                  |

<br />

## ⚙️ What do the configuration files give me?

- Customized Vim/Neovim configuration (includes a [colorscheme](https://github.com/QuantumZenoSix/gothic-cyberpunk.vim) I made)
- Customized Tmux configuration
- Spotify player tmux integration
- Specialized bash aliases, functions, and zsh extras.
- Customized Wezterm configuration
- Oh-my-zsh shell environment and and customized prompt


I've added bash functions to allow the changing between three prompt customizers: powerline10k, starship, and ohmyposh.  
Each can be further configured manually or using any of their respective presets.  

![Prompt Switching](./assets/prompt_changer.gif)

Absolutely unecessary, but fun.  

<br />

## ❄️ How are configuration files managed once installed?
This repo will be cloned and saved as `~/.config/home-manager`.  
Upon installation you'll have the option to manage config files via Nix.  
Choosing yes installs nix and uses the provided home.nix flake to sync your config files in `~/.config/home-manager/dotfiles` to their respective locations.  
Choosing no runs a simple copy command to copy the files in `~/.config/home-manager/dotfiles` to their respective locations.  

Note: I didn't hardcode a username in the home.nix flake. The username will auto-populate based on the user who's logged in. Meaning, anyone can fork this repo, edit the home.nix flake and it should still work.  

## ❔ What apps are included?

<br />

📱 __Base Applications__

A full list of base applications lives here: [Arch Install List](./pkg_lists/arch_base.txt)  

<br />

You can can add/remove from that list to determine which apps will be installed as well.  
Near the end of the file you'll see a line that reads  `NOTE-AUR: Processing AUR pkgs from this point on`.  
Include any packages that need to be installed from the AUR after that line; yay is installed automatically.  

<br />


📲 __Desktop Applications__  

For a full list, check out the cachy os script here: [Desktop.sh](./scripts/cachy_os_setup/desktop.sh)  

<br />

_General_
- Brave
- LibreOffice
- Obsidian
- Steam



_Dev_
- Docker
- Postman
- Thonny
- Wezterm
- Wireshark


_Media_
- Audacity
- MPV
- Gimp + Inkscape
- OBS
- Spotify
- VLC

_Social_
- Discord
- Signal
- Telegram

<br />


_Note: Some apps like vim/neovim are already included as part of the base applications. This section is more GUI focused_

<br />

## 🎮 What gaming enhancements are included with the 'DSK' desktop-oriented options?

The desktop os assumed here is Cachy OS.  

In addition to installing common desktop applications, the `desktop.sh` script does the following:
- Runs a GPU status check
- Installs common codecs, firmware, utilities
- Installs mangohud, goverlay, gamemode, vkbasalt, gamescope, winetricks, bottles, and more.
- Security/performance optimizations (apparmor, ufw, tlp, snapper)

Beyond that, the `housekeeping.sh` script does the following:
- Full system update
- Installs media codecs
- Updates flatpaks
- SSD/NVMe trim
- Cleanup (cache, orphans, journal, thumbnails, etc)
- Refresh font-cache + redetct hardware

<br />

## 🛠️ Will this support other distros besides Arch btw?

Yes, some work has already been done in the debian distro family (which now appears in the list) with the Pop! OS as the chosen desktop-oriented distro in this regard.  
More work is to be done for this, but have made it a priority as it's fairly functionality as is (though it lacks modularity as I don't have an entry in the `./pkg_lists` dir as of yet.
Fedora, maybe one day.



<br />

<br />

<br />

---

# My setup:
- Shell: zsh
- Shell Environment: Ohmyzsh (zsh theming and plugins)
- Prompt customizers: powerline10k, starship, and ohmyposh (overkill really)
- Edtor: Neovim/vim
- Multiplexer: Tmux
- Spotify-tmux integration (+10 rice-factor points)

Instead of re-configuring everything all over from scrath on a new system, I've created a script to install the necessary packages and copy the relevant config files so I can get my workflow up an running on any (ubuntu) system with a single command.

<br />

---


# CLI installation
One command to install packages and copy dotfiles.  
Everything you need to get going in a cli.  
Perfect for a quick install to get my main pkgs, prompt/shell customizations, and full neovim setup.  
Works for debian-based and arch-based distros. Haven't got to fedora update yet.  
<br />



Start Script (with selector)
```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/utils/start.sh -O -)"
```

Selector preview  
```sh
What would you like to download?
1. Everything (Packages, config files, customized shell/prompt, and Neovim configuration)
2. Packages
3. Config files
4. Neovim configuration
5. Arch-Nix hybrid (everything included in #1 but system-level packages are managed through Pacman and all other packages are managed via Nix using Home-Manager and Flakes)
```





<!-- Or, if you don't want the selector, call the script with yout predefined options.   -->
<!-- Replace `<type>` with the number of one of the options above.     -->
<!---->
<!-- ```bash -->
<!-- bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/start.sh <type> -O -)" -->
<!-- ``` -->

---  

## Full Installation  
Install all in ubuntu system _(installs packages and copies config files)  

```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/init_full.sh -O -)"
```

<br />

<br />

## Package Installation
Install programs in ubuntu system _(installs packages only)  

```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/init_installonly.sh -O -)"
```

<br />

<br />

## Config installation  
Install config files in ubuntu system _(config files only - includes nvim)  
```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/init_configonly.sh -O -)"
```
<br />

<br />

## Nvim-only installation_
Install config files in ubuntu system _(nvim files only)_

```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/init_nvimonly.sh -O -)"
```
<br />


<br />


# Full install


## Pop! OS Desktop installation  
Install packages and copies config files in ubuntu system.  
Additionally install preferred desktop applications, create .desktop images for AppImages, install and updates drives and gaming add-ons, perform updates and system cleanup.  
```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/init_os_pop.sh -O -)"
```
<br />



## Arch Linux and Arch-based installation  
Install packages and copies config files.  
Additionally install preferred desktop applications, create .desktop images for AppImages, install and updates drives and gaming add-ons, perform updates and system cleanup.  

__Dual Package managers__  
Uses pacman for system-level and os-level packages (drivers, sound/graphics, etc) and Nix for just about everything else.  
Config updates powered via Nix Home Manager + flake.  
```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/init_os_arch_nix.sh -O -)"
```
<br />
<!--
__Docker VM__:Create a Docker container running Ubuntu Jammy jellyfish (v22)  
```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/jammy_init.sh -O -)"
```
-->

# Prompt changer  
Having ohmyzsh as my shell environment, I've added bash functions to allow the changing between three prompt customizers: powerline10k, starship, and ohmyposh.  
Each can be further configured manually or using any of their respective presets.  

![Prompt Switching](./assets/prompt_changer.gif)

<br />

<br />

<br />

## Notes
`controller.sh` - Assumes the repo is cloned and installs packages. 
- Run with no arguments to install packages
- Run with "full" to install packages and copy the config files into the proper dirs.
- Run with with "configonly" to skip packages installation step and only copy config files to $HOME.

<br />

`init.sh` - Clones repo and runs `install.sh` (installing both packages and config files)  

<br />

# Notes about setup  

Local git repo: `~/Documents/Repos/Dev-Environment/`

## Important Keybinds  

<br />


| Key    | Description |
| --- |--|  
| `lcs`  | __Local config save__<br />Copy local config files on host system to local git repo and push changes up to GitHub. <br />_(Can also use `local_config_save` command)_              |  
| `lcu`  | __Local config update__<br />Pull latest changes down from GitHub to local git repo and update config files on host system. <br />_(Can also use `local_config_update` command)_   |




