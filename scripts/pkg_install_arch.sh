#!/usr/bin/env bash


AUR="yay -S --needed" 
PACMAN="$SUDO pacman -S --needed"

echo "# ──────────────────────────────────────────────────────────────────────────────────────────"
echo "#        PACKAGE INSTALLATION | Part I: System update and setting up access to AUR"
echo "# ──────────────────────────────────────────────────────────────────────────────────────────"




# ===========================================================================
set -u   # treat unset variables as error

file="./pkg_lists/arch_base.txt"

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found"
    exit 1
fi

echo "Reading packages from: $file"
echo "----------------------------------------"

mapfile -t packages < "$file"

# Remove empty lines and comments, keep only real package names
packages=("${packages[@]//[[:space:]]/}")          # trim whitespace
packages=("${packages[@]%%#*}")                    # remove inline comments
packages=("${packages[@]/#/}")                     # remove lines starting with #

# Filter out empty entries
packages=($(printf '%s\n' "${packages[@]}" | grep -v '^$'))

if (( ${#packages[@]} == 0 )); then
    echo "No valid packages found in the file."
    exit 1
fi

echo "Found ${#packages[@]} packages to install:"
printf '  - %s\n' "${packages[@]}"
echo

read -p "Continue with installation? (y/N) " answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

# Update system
yes | $SUDO pacman -Syu 

echo

for pkg in "${packages[@]}"; do
    echo "→ Installing $pkg"
    # sudo apt install -y "$pkg" || echo "  └─ failed"
    yes | $PACMAN "$pkg"
done

echo
echo "Installation finished."

exit
# ===========================================================================



# Essentials
$PACMAN  base-devel           # build-essential: GCC/make/etc for system builds/AUR 
yes | $PACMAN git 
yes | $PACMAN go 
yes | $PACMAN rustup  && rustup update

# Yay installation (for AUR) (needs go)
echo "[+] Installing yay..."
if [ "$(id -u)" -ne 0 ]; then
    git clone https://aur.archlinux.org/yay.git
    $SUDO chown -R ${CALLING_USER}:${CALLING_USER} yay && cd yay && makepkg -si  && cd ../
else
    printf "[+] Running as root, cannot install yay ['makepkg' command must not be run as root. Skipping AUR packages.]\n"
    AUR="echo Cannot install (yay not installed). Skipping "
fi



# Note: Ones  I didn't add 'yes' to are usually interactive and expect a choice to be made
echo "[+] Installing system-level tools (drivers, graphics, audio, compiler dependencies, os tools, etc)..."
# yes | $PACMAN 7zip
$PACMAN  font-manager   		# font-manager: GUI fonts 
yes | $PACMAN binutils  		# binutils: Assembler/linker, base-devel 
yes | $PACMAN bzip2  			# p7zip-full: 7zip compression 
yes | $PACMAN clang 
yes | $PACMAN cmake 
yes | $PACMAN coreutils  		# coreutils: GNU utils, base 
yes | $PACMAN curl  			# curl: Network downloader, system scripts rely on it 
yes | $PACMAN gawk  			# gawk: AWK, base 
yes | $PACMAN gcc  			# gcc: Compiler, base-devel 
yes | $PACMAN glibc  			# libc6: Core C lib 
yes | $PACMAN lib32-glibc  	# libc6-dev-i386: 32-bit libc dev 
yes | $PACMAN libxcb            # libxcb1-dev: XCB render, shape, etc
yes | $PACMAN llvm  
yes | $PACMAN make  			# make: Builder, base-devel 
yes | $PACMAN nasm 
yes | $PACMAN ninja 
yes | $PACMAN openssl           # libssl-dev: Crypto
yes | $PACMAN p7zip  			# p7zip-full: 7zip compression 
yes | $PACMAN perl 
yes | $PACMAN pkgconf  		# pkg-config: Build helper
yes | $PACMAN sed    			# sed: Text processor, base 
yes | $PACMAN tar    			# tar: Archiver, base system 
yes | $PACMAN unzip  			# unzip: Zip handler, base 
yes | $PACMAN wget  			# wget: Downloader, core for scripts 
yes | $PACMAN which 
yes | $PACMAN xclip  			# xclip: Clipboard, X11 integration 
yes | $PACMAN xsel  			# xsel: Clipboard, X11 


echo "[+] Installing media/sound-related pkgs..."
# Sound-related: Audio libs/hardware accel integration.
$PACMAN  alsa-lib --noconfirm    # libasound2-dev: ALSA 
$PACMAN ffmpeg    --noconfirm    # ffmpeg: Multimedia 
yes | $PACMAN dbus              # libdbus-1-dev: Bus 
yes | $PACMAN imagemagick
yes | $PACMAN libass            # libass9: Subtitles 
yes | $PACMAN libbluray         # libbluray2: Blu-ray 
yes | $PACMAN libcaca           # libcaca0: Graphics 
yes | $PACMAN libcdio           # libcdio-cdda2/libcdio-paranoia2/libcdio19: CDIO        
yes | $PACMAN ncurses           # libncursesw5-dev: Curses wide 
yes | $PACMAN playerctl         # playerctl: Media control 
yes | $PACMAN poppler           # poppler-utils (pdf → text/images utilities including pdftoppm, pdftohtml…)
yes | $PACMAN rubberband        # librubberband2: Audio stretch 


echo "[+] Installing Spotify Player dependencies..."

# 1. Modern / recommended (PipeWire + official package)
$PACMAN libsixel spotify-player pavucontrol --noconfirm   # pavucontrol still works via pipewire-pulse

# ────────────────────────────────────────────────
# 2. OR if you insist on PulseAudio backend:
# sudo pacman -S --needed pulseaudio pulseaudio-bluetooth pavucontrol libsixel

# Then (if not using the official package):
# cargo install spotify_player --no-default-features --features pulseaudio-backend,media-control,sixel --force

# 3. Or if you prefer building from source with your chosen features:
#    (most common choice today = gstreamer backend = native PipeWire support)
# cargo install spotify_player --no-default-features --features "gstreamer-backend,media-control,sixel,image,notify,lyric-finder"


# PipeWire check        
if systemctl --user is-active pipewire >/dev/null; then
    yes | $PACMAN pipewire      # libpipewire-0.3-0: PipeWire lib 
fi

echo "[+] Installing graphics-related pkgs..."
# Vulkan/graphics: GPU driver integration.
yes | $PACMAN mesa-utils        # mesa-utils vulkan-tools: Graphics tools 





# TODO: NIXIFY

echo "[+] Installing programming languages and tools..."
# System dev/build tools: Compilers/linkers for kernel modules/AUR; libs for system-wide linking.
yes | $PACMAN tree  			
yes | $PACMAN less  			# tar: Archiver, base system 
yes | $PACMAN direnv 
yes | $PACMAN bash  			# bash: Shell, base 
yes | $PACMAN gettext  		# gettext: Localization, system 
yes | $PACMAN jq
yes | $PACMAN lua 
yes | $PACMAN nvm 
yes | $PACMAN pipx 
yes | $PACMAN neovim 
yes | $PACMAN python 
yes | $PACMAN ufw  			# gawk: AWK, base 
yes | $PACMAN uv || yes | $AUR uv
yes | $PACMAN nodejs-lts-jod


echo "[+] Installing workflow and cli tools..."
yes | $AUR  jless                     # json viewer
yes | $PACMAN bc  		    # bc: Calculator, base 
yes | $PACMAN tmux
yes | $PACMAN entr
yes | $PACMAN fzf 
yes | $PACMAN python-pygments 
yes | $PACMAN ripgrep 
yes | $PACMAN tmux 
yes | $PACMAN vim   			# vim-gtk3: GUI vim with GTK/X11 
yes | $PACMAN zsh 



echo "[+] Installing  system/misc tools..."
# Terminal/system extras: System integration like fonts/GUI/audio mounts.
yes | $PACMAN powerline-fonts	# fonts-powerline: Fonts for terminals 
yes | $PACMAN sshfs  			# sshfs: FUSE mount, system fs 
yes | $PACMAN sshpass  		# sshpass: SSH passwords, utils 

echo "[+] Installing misc. tools..."
# Misc tools: System info/process viewers.
yes | $PACMAN docker            # docker.io: Containers, system service 
yes | $PACMAN docker-compose    # docker-compose-plugin: Docker compose 
yes | $PACMAN entr              # entr ─ super useful file watcher (needed for tmux autoreload)
yes | $PACMAN fastfetch         # fastfetch: System info
yes | $PACMAN fd                # → fd
yes | $PACMAN glow              # Markdown reader
yes | $PACMAN htop              # htop: Process viewer 
yes | $PACMAN pandoc  
yes | $PACMAN unixodbc          # unixodbc-dev: ODBC 
yes | $PACMAN yt-dlp            # YouTube downloader



echo "# ──────────────────────────────────────────────────────────────────────────────────────────"
echo "#        PACKAGE INSTALLATION | Part II: Installing AUR pkgs (or potential AUR pkgs)"
echo "# ──────────────────────────────────────────────────────────────────────────────────────────"

echo "[+] Installing AUR pkgs (or potential AUR pkgs)..."
yes | $AUR  zimg                      # libzimg2: Image scaling 
yes | $AUR  mlocate                   # locate: File indexer, system db 

# Cargo-based tools ─ many have AUR packages (faster, no need to keep cargo cache)
yes | $PACMAN csvlens        || yes | $AUR csvlens      # very popular
yes | $PACMAN dust           || yes | $AUR du-dust      # → dust
yes | $PACMAN yazi           || yes | $AUR yazi         # excellent file manager, now in community/extra in recent years

# Go-based tools ─ most in AUR or official repos
yes | $PACMAN lazygit        || yes | $AUR lazygit              # official repo now
yes | $AUR lazysql           # almost always AUR
yes | $AUR eget              # usually AUR
yes | $AUR ggh               # SSH session manager – AUR

# lazydocker → usually AUR or curl script still works
yes | $AUR lazydocker        || curl -sSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# posting (HTTP client – python) – now has AUR package
yes | $AUR posting           || uv tool install --python 3.13 posting   # fallback

# Source and install node version
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if command -v nvm >/dev/null; then
    echo "nvm installation suceeded. installing version."
    # echo -e "\t[!] Available nvm versions:"
    # nvm list-remote       # avaiable versions
    echo -e "\t[+] Installing node v22..."
    nvm install v22.17.0  # install a version
    echo -e "\t[+] Installed versions:"
    nvm list              # View installed versions
    echo -e "\t[+] Selecting v22.17"
    nvm use v22.17.0 
fi

# NOT USING AT THE MOMENT
# $AUR  mssql-tools  # mssql-tools: MS SQL tools, AUR 
# $AUR  aarch64-linux-gnu-gcc  # crossbuild-essential-arm64: ARM cross-compiler, AUR 
# $AUR  tufw  # GUI for ufw
# yes | $PACMAN gvim  # vim-gtk3: GUI vim with GTK/X11 
# $PACMAN zoxide         || $AUR zoxide

echo "Pacman installations complete."

echo "[+] Enabling Docker service..."
$SUDO  systemctl enable docker
$SUDO  systemctl start docker



if [ "${INSTALL_SUBTYPE}" = "os-cachy" ]; then

    printf "\n\n"
    echo "# ────────────────────────────────────────────────"
    echo "#        POP! OS | Installing Desktop Packages "
    echo "# ────────────────────────────────────────────────"
    printf "\n\n"
        
    cd $(dirname "$0") && pwd || exit

    # TODO: Cachy scripts
    #
    echo "Running dry run first..."
    # bash ../setups/pop_os_setup/core.sh 1   

    printf "[+] Dry run complete! Review results. \n\nLive run will execute in 20s if this script isn't aborted with Ctrl+c\n\n"
    sleep 20
    # bash ../setups/pop_os_setup/core.sh 0
    
    echo "[+] Installing additional packages for gaming/graphics updates"
    # bash ../setups/pop_os_setup/gaming.sh

    echo "[+] Running housekeeping tasks"
    # bash ../setups/pop_os_setup/housekeeping.sh

fi

