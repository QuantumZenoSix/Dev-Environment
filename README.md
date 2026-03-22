# My setup:
- Shell: zsh
- Shell Environment: Ohmyzsh (zsh theming and plugins)
- Prompt customizers: powerline10k, starship, and ohmyposh (overkill really)
- Edtor: Neovim/vim
- Multiplexer: Tmux
- Spotify-tmux integration (+10 rice-factor points)

Instead of re-configuring everything all over from scrath on a new system, I've created a script to install the necessary packages and copy the relevant config files so I can get my workflow up an running on any (ubuntu) system with a single command.

<br />

# CLI installation
One command to install packages and copy dotfiles.  
Everything you need to get going in a cli.  
Perfect for a quick install to get my main pkgs, prompt/shell customizations, and full neovim setup.  
Works for debian-based and arch-based distros. Haven't got to fedora update yet.  
<br />



Start Script (with selector)
```bash
bash -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/scripts/start.sh -O -)"
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
`install.sh` - Assumes the repo is cloned and installs packages. 
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




