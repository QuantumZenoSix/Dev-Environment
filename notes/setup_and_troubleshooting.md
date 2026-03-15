
# Table of Contents

- [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Reference: Included Programs](#reference-included-programs)
  - [Included in Common Programs list but could benefit from a later version](#included-in-common-programs-list-but-could-benefit-from-a-later-version)
  - [Reference: Handled by install.sh script and/or config files](#reference-handled-by-installsh-script-andor-config-files)
    - [ZSH](#zsh)
    - [VIM](#vim)
- [System Compatibility](#system-compatability)
  - [Enabling Systemd](#enabling-systemd)
  - [Running Neovim on older machines](#running-neovim-on-older-machines)
  - [Updating WSL, Ubuntu distro, and GLIBC](#updating-wsl-ubuntu-distro-and-glibc)
- [Troubleshooting](#troubleshooting)
  - [Troubleshooting WSL](#troubleshooting-wsl)
    - [Display Issues](#display-issues)
  - [Troubleshooting Display/Graphics Issues](#troubleshooting-displaygraphics-issues)
- [Misc Neovim configurations and installs](#misc-neovim-configurations-and-installs)
  - [Install perl language server](#install-perl-language-server)
  - [Perl syntax highlighting](#perl-syntax-highlighting)
  - [Dadbod DB setup](#dadbod-db-setup)
  - [Kickstart notes](#kickstart-notes)
- [Shell tools](#shell-tools)
  - [Harlequin SQL](#harlequin-sql)
<br />

# Setup

<br />

## Prerequisites  

- [Install Wezterm Editor](https://wezfurlong.org/wezterm/install/linux.html)  
If on WSL then you will need to copy your ~/.wezterm.lua file to your windows home dir: `cp ~/.wezterm.lua /mnt/c/Users/<username>`  
- [Download and Install a NerdFont](https://www.nerdfonts.com/)
I already have the JetBrains fonts I prefer zipped up in this repo.  
~~[OLD] For WSL I used to install "MesloLGS NF" and "DroidSansM Nerd Font" and set the "DroidSansM" in terminal. DroidSansM: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DroidSansMono.zip~~  
Another font thats worth installing as it comes up in some packages [Noto Font](https://fonts.google.com/noto/specimen/Noto+Sans)


<br />

## Reference: Included Programs

<br />


Note: You'll find all these programs to install in the install.sh file so if you rin the scripts in the README.md you shoudln't have to manualy install any of these.
However, I've added these to highlight some specific ones that are included and add some some extra info/documentation on some programs I've included.
- [uv](https://docs.astral.sh/)
- [go](https://go.dev/doc/install)
- [ggh](https://github.com/byawitz/ggh)
- [Tere (cd + ls)](https://github.com/mgunyho/tere)
- [Dust](https://github.com/bootandy/dust)
- [Youtube Downloader](https://github.com/yt-dlp/yt-dlp)
- [tufw](https://github.com/peltho/tufw)
- [csvlens](https://github.com/YS-L/csvlens)
- [Eget](https://github.com/zyedidia/eget)  
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Lazydocker](https://github.com/jesseduffield/lazydocker)
- [Posting](https://github.com/darrenburns/posting)
- [mpv](https://mpv.io/)
- [Yazi file manager](https://yazi-rs.github.io/docs/installation/#debian)


<br />



**Included in Common Programs list but could benefit from a later version**  
Some packages are best to download from source and compile to make sure we get the latest version:  
- [Install Python](https://www.python.org/downloads/source/)  
- [Install Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download)    
- [Install fzf](https://github.com/junegunn/fzf)
- [Install tmux: Terminal MultiPlexer](https://github.com/tmux/tmux/wiki/Installing)
- [Install tmux plugin manager](https://github.com/tmux-plugins/tpm)
- [Install powerline fonts](https://github.com/powerline/fonts)
- [Playerctl](https://github.com/altdesktop/playerctl)
- [Pandoc](https://github.com/jgm/pandoc)
- [Install node version manager (nvm)](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)  ([Alternate installation methods](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04))
  ```bash
    # NVM
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash # Install nvm version 0.40.3
    nvm list-remote       # avaiable versions
    nvm install v14.10.0  # install a version
    nvm list              # View installed versions
    nvm use v14.10.0      # Use specific version
   ```
  - One cmd: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` 
- [Install Catppuccin Theme](https://github.com/catppuccin/tmux)
  - Already installed if tpm is installed. 
  - Install all plugins loaded with `<prefix>+I` in a tmux session.
  - Replace ~/.tmux.conf with saved one and source with `tmux source-file ~/.tmux.conf`

<br />

<br />

## Reference: Handled by install.sh script and/or config files

Again, just adding these for reference to klnow what was installed and how to usually go about setting these things up.
### ZSH 
- [Install ZSH with OhMyZsh](https://ohmyz.sh/) 
  - ⚠️Replace ~/.zshrc with one saved.
- [ZSH Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
  - ⚠️ This can be skipped if you're copying my ~/.zshrc (I already have bit in zshrc that checks and clones repo)  
  - Just run this (Ubuntu) .zsrhc already has needed snippet (checks for /usr/share/zsh-syntax-highlighting)
  - ```bash
      sudo apt install zsh-syntax-highlighting -y
    ```  
- [Install Powerline10k Theme](https://github.com/romkatv/powerlevel10k)
  - ⚠️ _(use ohmyzsh installation)_
  - Be sure to install the fonts mentioned and select those fonts for your terminal.
  - Replace ~/.p10k.zshrc with one saved and source.
  - [Font glyphs from Nerdfont](https://www.nerdfonts.com/cheat-sheet)
- [Install ZSH syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
  - One cmd: `mkdir ~/zsh_utils/ && cd ~/zsh_utils && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git`
- [Tmux goodies](https://github.com/rothgar/awesome-tmux?tab=readme-ov-file)

<br />

### VIM
- [Install Vim-Plug plugin manager](https://github.com/junegunn/vim-plug)
- - Actually, this is more of a backup as I've added the auto-install snippet for vim-plug into the .vimrc file
- Replace ~/.vimrc with saved one (source with :so % or just close/re-open)
- If you have ~/.vimrc.plug, replace that with saved ones
- Load plugins by opening .vimrc or vimrc.plug file (whichever has plugins loaded) and running `:PlugInstall`
- Make sure to do both the Linux and Neovim install

<br />

<br />

## System Compatability

### Enabling Systemd  
Edit /etc/wsl.conf in your WSL distribution:
sudo nano /etc/wsl.conf
```bash
[boot]
systemd=true
```

<br />

Verify systemd is running:
`systemctl --user status dbus`

<br />

### Running Neovim on older machines  
https://mihai.fm/running-neovim-on-older-linux-boxes/  
https://stackoverflow.com/questions/46534957/configure-error-these-critical-programs-are-missing-or-too-old-gcc-make-w/62252633#62252633  

Force system to look at a specific GLIBC:  
```bash
patchelf --set-interpreter /home/ubuntu/glibc/lib/ld-linux-x86-64.so.2 --set-rpath /home/ubuntu/glibc/lib:/usr/lib64 ./nvim-linux64/bin/nvim
```


This is a very common trick to make a prebuilt Linux binary (like the official nvim-linux64 tarball from GitHub releases) run on a system with an older glibc version than what Neovim was compiled against.

<br />

### Updating WSL, Ubuntu distro, and GLIC
Updating your ubuntu distro in WSL (in case its like < 24.0) and GLIBC  
If you're on an older version of ubuntu, it may use an older version of GLIBC like 2.31. Programs like yazi (ya package manager) and Neovim (particularly it's LSP features) require a newer GLIBC. Since manually updating GLIBC isn't recomended we need to update the distro to get the latest GLIBC for our system.  

Not recomended, but you can manually download+install glibc [here](https://ftp.gnu.org/gnu/glibc/)  

<br />

Check GLIBC version
```bash
ldd --version
```

Check distro  
```bash
lsb_release -r
# OR
cat /etc/os-release
```

<br />

__GLIBC compatibility on recent versions__  

```
Ubuntu 20.04 (Focal): glibc 2.31
Ubuntu 22.04 (Jammy): glibc 2.35
Ubuntu 24.04 (Noble): glibc 2.39
Ubuntu 24.10 (Oracular): glibc 2.40
Ubuntu 25.04 (Plucky): glibc 2.41
```


<br />

Update WSL to pre-release version (windows)  
```cmd
wsl --update --pre-release
```

Check latest compatible GLIBC for our system and the one installed  
```bash
sudo apt-cache policy libc6
# ---------------------------
# libc6:
#  Installed: 2.35-0ubuntu3.1
#  Candidate: 2.35-0ubuntu3.9
```

<br />

If there's a newer version available then whats installed, install the latest version  
```bash
sudo apt update && sudo apt install libc6 -y
```

<br />

Optionally, you can perform a full distribution and release upgrade  
```bash
sudo apt update
sudo apt full-upgrade -y   # full distribution upgrade
sudo do-release-upgrade    # full release upgrade
```

Then shutdown and start wsl back up again  
```cmd
wsl --shutdown
```

---

<br />



# Troubleshooting

## Troubleshooting WSL

### Display Issues
I've been using this without issue in WSL, butin case you're having issues, it could be to do with your `DISPLAY1 environment variable.
If you still get the “cannot open display” error, set the DISPLAY variable as shown below.
```bash
echo "export DISPLAY=localhost:0.0" >> ~/.bashrc
```
Note: IP is the local workstation’s IP where you want the GUI application to be displayed.  

__Helpful Related Links (WSL + GUI)__
- [Link 0](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)
- [Link 1](https://aalonso.dev/blog/how-to-use-gui-apps-in-wsl2-forwarding-x-server-cdj)
- [Link 2](https://wiki.ubuntu.com/WSL#Running_Graphical_Applications)
- [Link 3](https://wiki.iihe.ac.be/Use_X11_forwarding_with_WSL)



## Troubleshooting Display/Graphics Issues


__Installing vulkan drivers (Graphics card drivers)__

```bash
sudo apt update
sudo apt install mesa-utils vulkan-tools
```

<br />



---




# Misc Neovim configurations and installs

<br />

## Install perl language server

General Guide: https://climatechangechat.com/setting_up_lsp_nvim-lspconfig_and_perl_in_neovim.html#basic-setup-get-a-perl-language-server-up-and-running-with-neovim


--- Install PLS package
```
perl -MCPAN -e shell
install PLS
```

add this into `init.lua` OR `~/.config/nvim/lua/config/.lua`  

```
local lspconfig = require("lspconfig")

-- Perl PLS (Perl Language Server)
lspconfig.perlpls.setup({})
```

<br />

## Perl syntax highlighting ###

Install Treesitter-perl: https://metacpan.org/pod/Text::Treesitter

In your `~/.config/nvim/lua/plugins/treesitter.lua` (or a similar file where you configure plugins):

```lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Ensure that Tree-sitter parsers are installed
      ensure_installed = {
        "perl", -- Add Perl as a language to be supported by Tree-sitter
        -- You can include other languages here too
      },
      highlight = {
        enable = true, -- Enable syntax highlighting
      },
    })
  end,
}
```

<br />

---


## __Dadbod DB setup__

A neovim plugin to run SQL  
- Install MySql
 ```bash
sudo apt install mysql-server
```
- Install sqlcmd: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver16&tabs=redhat-install
- Install ODBC: https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16&tabs=alpine18-install%2Calpine17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline

Adding Connections:
- sql server: `sqlserver://{user}:{password>}@{host>}:{port}/{database}?trustServerCertificate=yes`  
- mysql: `mysql://{user}:{password}@{host}:{port}/{database}`

<br />

Executing query under cursor with `<leader>rr`, add this custom key binding (lua).
```lua
vim.keymap.set('n', '<leader>rr', '<Plug>(DBUI_ExecuteQuery)', { desc= 'Execute query under cursor (DBUI)', noremap = true, silent = true })
```
<rbr />

Config File:  
```toml
[profiles.sscore-dev]
#adapter = "odbc"
# server = "X"
# port = 1433
#database = "X"
# uid = "X"
#pwd = "X"
# driver = "ODBC Driver 18 for SQL Server"
# Optional parameters
#trusted_connection = "yes"
#encrypt = "yes"

connection_string = "Driver={ODBC Driver 18 for SQL Server};Server=tcp:{SERVER},{PORT};Database={DB};Uid={USER};Pwd={PASS};Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;"
keymap_name = ["vscode"]
theme = "tokyo-night"

# DEFAULT PROFILE
[harlequin.adapters.odbc]
connection_string = "Driver={ODBC Driver 18 for SQL Server};Server=tcp:{SERVER},{PORT};Database={DB};Uid={USER};Pwd={PASS};Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;"
```

<br />

## Kickstart notes  
https://github.com/QuantumZenoSix/kickstart.nvim.git  
`git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim-kickstart`  
When you run Neovim using nvim-kickstart alias it will use the alternative config directory and the matching local directory ~/.local/share/nvim-kickstart. You can apply this approach to any Neovim distribution that you would like to try out.  
`alias nvim-custom='NVIM_APPNAME="nvim-kickstart" nvim'`

<br />


# Shell tools  


## Harlequin SQL  

Though I don't currently have it installed, harlequin is a great TUI for executing SQL queries.  

[Harlequin](https://github.com/tconbeer/harlequin)  
- `F2` - focus on query editor  
- `F5` Focus on the Results Viewer.  
- `F6` Focus on the Data Catalog.  
- `F8` Show the Query History Viewer.  
- `F9`, `ctrl+b` Toggle the sidebar.  
- `F10` Toggle full screen mode for the current widget.  
- `ctrl+e` Export the returned data to a CSV, Parquet, or JSON file.  
- `ctrl+r` Refresh the Data Catalog.  
- `ctrl+enter`, `ctrl+j` Run the query  
- `ctrl+s` Save the contents of the Query Editor to a file.  
- `ctrl+n` Create a new buffer (editor tab).  
- `ctrl+w` Close the current buffer (editor tab).  
- `ctrl+k` View the next buffer (editor tab).  
- `ctrl+/`, `ctrl+\_` Toggle comments on selected line(s).  
- MySQL Connection: `harlequin -a mysql -h server.com -p 3306 -U user --password pass --theme tokyo-night`  
- SQL Server: `harlequin -a odbc 'Driver={ODBC Driver 18 for SQL Server};Server=tcp:server.com,1433;Database=mydb;Uid=user;Pwd=pass;Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;' --theme tokyo-night`  

Initialize project, Install harlequin, and add adapters
```bash
uv init
uv tool install harlequin
uv tool install 'harlequin[postgres,mysql,s3,odbc]'
sudo apt install unixodbc -y # ODBC
```

<br />



