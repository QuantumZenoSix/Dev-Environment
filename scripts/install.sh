#!/bin/sh
# Installation of packages and copying of config files

# set -euo pipefail  # safer bash scripting

CALLING_USER=$(whoami)

# Maintain user's home (even if calling with sudo)
HOME=$(getent passwd "$CALLING_USER" | cut -d: -f6)

SUDO=""

# if not root, run as sudo
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
    printf "[+] Not running as root - adding sudo\n"
else
    printf "[+] Running as root\n"
fi

# Install latest
if [ -d ./Dev-Environment/ ]; then
    echo "Found Dev-Environment. Re-cloning..."
    $SUDO rm -rf ./Dev-Environment
fi

# ────────────────────────────────────────────────
#             Distro Detection
# ────────────────────────────────────────────────

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
else
    echo "Error: /etc/os-release not found — cannot reliably detect distribution"
    exit 1
fi

# Normalize to lower case and check family
ID_LIKE="${ID_LIKE:-$ID}"
ID_LIKE=$(echo "$ID_LIKE" | tr '[:upper:]' '[:lower:]')

if echo "$ID_LIKE" | grep -q -E 'debian|ubuntu|pop|linuxmint|zorin'; then
    DISTRO_FAMILY="debian"
    PKG_MANAGER="apt"
    echo "[+] Detected Debian-based system (using apt)"
elif echo "$ID" "$ID_LIKE" | grep -q -E 'fedora|nobara|rhel|centos|rocky|almalinux'; then
    DISTRO_FAMILY="fedora"
    PKG_MANAGER="dnf"
    echo "[+] Detected Fedora-based / RPM-based system (using dnf)"
elif echo "$ID" "$ID_LIKE" | grep -q -E 'arch|cachy'; then
    DISTRO_FAMILY="arch"
    PKG_MANAGER="pacman"
    echo "[+] Detected Arch-based (using pacman)"
else
    echo "Error: Unsupported distribution."
    echo "       Detected ID=$ID  ID_LIKE=$ID_LIKE"
    echo "       This script currently supports only Debian-family, Arch,  and Fedora-family systems."
    exit 1
fi





# ────────────────────────────────────────────────
#             NVIM-ONLY MODE (distro agnostic)
# ────────────────────────────────────────────────

if [ "$1" = "nvimonly" ]; then
    # __________ NVIM __________
    if [ -d $HOME/.config/nvim/ ]; then
        mkdir -p $HOME/.config/nvim
    fi

    # [.config] If backup folder exists remove it so we can overwrite it
    if [ -d $HOME/.config/nvim-backup ]; then
        rm -rf $HOME/.config/nvim-backup
    fi
    [ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$HOME/.config/nvim-backup"
    cp -v -r ./config/.config/nvim  $HOME/.config/

    # [.local] If backup folder exists remove it so we can overwrite it
    [ -d "$HOME/.local/share/nvim-backup" ] && rm -rf "$HOME/.local/share/nvim-backup"
    [ -d "$HOME/.local/share/nvim" ] && mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim-backup"

    echo "[+] Nvim files copied!"

    # Vim
    cp -f -v ./config/config/.vimrc  $HOME/
    if [ -d $HOME/.vim/ ]; then
        mkdir -p $HOME/.vim
    fi
    cp -f -v -r ./config/nvim/colors  $HOME/.vim/
    echo "[+] Vim files copied!"

    exit 0
fi

# ────────────────────────────────────────────────
#        PACKAGE INSTALLATION (skip if configonly)
# ────────────────────────────────────────────────

# ------------------------------------------------------------------------
# Unless we're explicitly calling to only copy the configs, then let's start installing
if [ "$1" != "configonly" ]; then

    if [ "$DISTRO_FAMILY" = "debian" ]; then

        printf "\n\n"
        echo "# ────────────────────────────────────────────────────────────────────────"
        echo "#        PACKAGE INSTALLATION (Part I: Core install from package manager)"
        echo "# ────────────────────────────────────────────────────────────────────────"
        printf "\n\n"

        if ! command -v apt >/dev/null || ! grep -qi ubuntu /etc/os-release; then
            echo "This script requires an Ubuntu-based system"
            exit 1
        fi
        
        echo "[+] Updating package lists (Debian/Ubuntu)..."
        # $SUDO apt update || { echo "Failed to update package lists"; exit 1; }
        $SUDO apt update 
        
        echo "[+] Installing essential core packages..."    # Not essential per se, but essentials for my workflow,enchancements, and customizations
        command -v curl >/dev/null 2>&1 || sudo apt install curl -y
        command -v curl >/dev/null 2>&1 || $SUDO apt install curl -y
        command -v wget >/dev/null 2>&1 || $SUDO apt install wget -y
        command -v tar >/dev/null 2>&1 || $SUDO apt install tar -y
        command -v unzip >/dev/null 2>&1 || $SUDO apt install unzip -y
        command -v xclip >/dev/null 2>&1 || $SUDO apt install xclip -y
        command -v build-essential >/dev/null 2>&1 || $SUDO apt install build-essential -y
        command -v locate >/dev/null 2>&1 || $SUDO apt install locate -y
        command -v sed >/dev/null 2>&1 || $SUDO apt install sed -y
        command -v coreutils >/dev/null 2>&1 || $SUDO apt install coreutils -y
        command -v vim >/dev/null 2>&1 || $SUDO apt install vim-gtk3 -y
        command -v vim-gtk3 >/dev/null 2>&1 || $SUDO apt install vim-gtk3 -y # GUI VIM
        command -v libc6 >/dev/null 2>&1 || $SUDO apt install libc6 -y
        command -v p7zip-full >/dev/null 2>&1 || $SUDO apt install p7zip-full -y

        # Languages
        echo "[+] Installing dev related packages..."    # Not essential per se, but essentials for my workflow,enchancements, and customizations
        command -v python3 >/dev/null 2>&1 || $SUDO apt install python3 -y
        command -v perl >/dev/null 2>&1 || $SUDO apt install perl -y
        command -v make >/dev/null 2>&1 || $SUDO apt install make -y
        command -v gcc >/dev/null 2>&1 || $SUDO apt install gcc -y
        command -v git-all >/dev/null 2>&1 || $SUDO apt install git-all -y
        command -v cmake >/dev/null 2>&1 || $SUDO apt install cmake -y
        command -v libstdc++6 >/dev/null 2>&1 || $SUDO apt install libstdc++6 -y
        command -v libc6-dev >/dev/null 2>&1 || $SUDO apt install libc6-dev -y
        command -v libc6-dev-i386 >/dev/null 2>&1 || $SUDO apt install libc6-dev-i386 -y
        command -v nasm >/dev/null 2>&1 || $SUDO apt install nasm -y
        command -v binutils >/dev/null 2>&1 || $SUDO apt install binutils -y
        command -v bc >/dev/null 2>&1 || $SUDO apt install bc -y
        command -v cargo >/dev/null 2>&1 || $SUDO apt install cargo -y
        command -v pandoc >/dev/null 2>&1 || $SUDO apt install pandoc -y
        command -v nodejs >/dev/null 2>&1 || $SUDO apt install nodejs -y
        command -v npm >/dev/null 2>&1 || $SUDO apt install npm -y
        command -v ninja-build >/dev/null 2>&1 || $SUDO apt install ninja-build -y
        command -v gettext >/dev/null 2>&1 || $SUDO apt install gettext -y
        command -v lua5.3 >/dev/null 2>&1 || $SUDO apt install lua5.3 -y
        command -v jq >/dev/null 2>&1 || $SUDO apt install jq -y
        command -v python3-pygments >/dev/null 2>&1 || $SUDO apt install python3-pygments -y
        command -v bash >/dev/null 2>&1 || $SUDO apt install bash -y
        command -v gawk >/dev/null 2>&1 || $SUDO apt install gawk -y
        command -v pipx >/dev/null 2>&1 || $SUDO apt install pipx -y
        pipx ensurepath
        
        echo "[+] Installing terminal/workflow extras..."
        command -v zsh >/dev/null 2>&1 || $SUDO apt install zsh -y
        command -v tmux >/dev/null 2>&1 || $SUDO apt install tmux -y
        command -v sshfs >/dev/null 2>&1 || $SUDO apt install sshfs -y
        command -v sshpass >/dev/null 2>&1 || $SUDO apt install sshpass -y
        command -v xsel >/dev/null 2>&1 || $SUDO apt install xsel -y
        command -v tree >/dev/null 2>&1 || $SUDO apt install tree -y
        command -v fonts-powerline >/dev/null 2>&1 || $SUDO apt install fonts-powerline -y
        command -v pkg-config >/dev/null 2>&1 || $SUDO apt install pkg-config -y
        command -v font-manager >/dev/null 2>&1 || $SUDO apt install font-manager -y # GUI
        command -v direnv >/dev/null 2>&1 || $SUDO apt install direnv -y
        command -v clang >/dev/null 2>&1 || $SUDO apt install clang -y
        # command -v mssql-tools --ignore-missing >/dev/null 2>&1 || $SUDO apt install mssql-tools --ignore-missing -y   # Requires MicrSoft repo
        
        echo "[+] Installing misc tools..."
        # Fastfetch
        $SUDO add-apt-repository ppa:zhangsongcui3371/fastfetch
        $SUDO apt update
        command -v fastfetch >/dev/null 2>&1 || $SUDO apt install fastfetch -y

        command -v htop >/dev/null 2>&1 || $SUDO apt install htop -y

        echo "[+] Installing various dependencies..."
        command -v pkg-config >/dev/null 2>&1 || $SUDO apt install pkg-config -y
        command -v libssl-dev >/dev/null 2>&1 || $SUDO apt install libssl-dev -y
        command -v libxcb1-dev >/dev/null 2>&1 || $SUDO apt install libxcb1-dev -y
        command -v libxcb-render0-dev >/dev/null 2>&1 || $SUDO apt install libxcb-render0-dev -y
        command -v libxcb-shape0-dev >/dev/null 2>&1 || $SUDO apt install libxcb-shape0-dev -y
        command -v libxcb-xfixes0-dev >/dev/null 2>&1 || $SUDO apt install libxcb-xfixes0-dev -y
        # command -v crossbuild-essential-arm64 >/dev/null 2>&1 || $SUDO apt install crossbuild-essential-arm64 -y

        echo "[+] Installing various dependencies (fragile)..." # Packages which may not be found in older package repos
        command -v fzf >/dev/null 2>&1 || $SUDO apt install fzf -y
        command -v ripgrep >/dev/null 2>&1 || $SUDO apt install ripgrep -y
        command -v unixodbc-dev >/dev/null 2>&1 || $SUDO apt install unixodbc-dev -y
        command -v docker.io >/dev/null 2>&1 || $SUDO apt install docker.io -y
        command -v docker-compose-plugin >/dev/null 2>&1 || $SUDO apt install docker-compose-plugin -y
        
        echo "[+] Installing various sound-related dependencies..."
        $SUDO add-apt-repository ppa:ubuntuhandbook1/ffmpeg6
        command -v playerctl >/dev/null 2>&1 || $SUDO apt install playerctl -y
        command -v libasound2-dev >/dev/null 2>&1 || $SUDO apt install libasound2-dev -y
        command -v ffmpeg >/dev/null 2>&1 || $SUDO apt install ffmpeg -y
        command -v libass9 >/dev/null 2>&1 || $SUDO apt install libass9 -y
        command -v libbluray2 >/dev/null 2>&1 || $SUDO apt install libbluray2 -y
        command -v libcaca0 >/dev/null 2>&1 || $SUDO apt install libcaca0 -y
        command -v libcdio-cdda2 >/dev/null 2>&1 || $SUDO apt install libcdio-cdda2 -y
        command -v libcdio-paranoia2 >/dev/null 2>&1 || $SUDO apt install libcdio-paranoia2 -y
        command -v libcdio19 >/dev/null 2>&1 || $SUDO apt install libcdio19 -y
        command -v librubberband2 >/dev/null 2>&1 || $SUDO apt install librubberband2 -y
        command -v libzimg2 >/dev/null 2>&1 || $SUDO apt install libzimg2 -y
        command -v libdbus-1-dev >/dev/null 2>&1 || $SUDO apt install libdbus-1-dev -y
        command -v libncursesw5-dev >/dev/null 2>&1 || $SUDO apt install libncursesw5-dev -y
        command -v libpulse-dev >/dev/null 2>&1 || $SUDO apt install libpulse-dev -y
        command -v libssl-dev >/dev/null 2>&1 || $SUDO apt install libssl-dev -y
        command -v libxcb1-dev >/dev/null 2>&1 || $SUDO apt install libxcb1-dev -y
        command -v libxcb-render0-dev >/dev/null 2>&1 || $SUDO apt install libxcb-render0-dev -y
        command -v libxcb-shape0-dev >/dev/null 2>&1 || $SUDO apt install libxcb-shape0-dev -y
        command -v libxcb-xfixes0-dev >/dev/null 2>&1 || $SUDO apt install libxcb-xfixes0-dev -y

        if systemctl --user is-active pipewire >/dev/null; then
            echo "Using PipeWire, installing specific dependencies..."
            command -v libpipewire-0.3-0  >/dev/null 2>&1 || $SUDO apt install libpipewire-0.3-0  -y
        fi

        echo "[+] (optional) installing vulkan graphics drivers..."
        command -v vulkan-tools >/dev/null 2>&1 || $SUDO apt install vulkan-tools -y
        command -v mesa-utils >/dev/null 2>&1 || $SUDO apt install mesa-utils -y

        echo "[+] Installing Tufw (UFW GUI)..."
        $SUDO  wget https://github.com/peltho/tufw/releases/download/v0.2.4/tufw_0.2.4_linux_amd64.deb -O ./tufw_0.2.4_linux_amd64.deb
        $SUDO  apt install ./tufw_0.2.4_linux_amd64.deb -y
        $SUDO  rm ./tufw_0.2.4_linux_amd64.deb

        # Keep at end
        printf "[+] Removing stale lockfiles...\n\n"
        $SUDO rm -f /var/lib/dpkg/lock-frontend
        $SUDO rm -f /var/lib/dpkg/lock


        # ────────────────────────────────────────────────
        #         Distro-agnostic tool installs
        # ──────────────────────────────────────────────── 

        echo "# ────────────────────────────────────────────────"
        echo "#        PACKAGE INSTALLATION (Part II: Distro-agnostic Tools not via package manager)"
        echo "# ────────────────────────────────────────────────"

        # Software that isn't installed via a distro's package manager (may contain fixed versions). The order below is important.
        echo "[+] Installing prerequisites!"

        echo "[+] Enabling docker service..."
        $SUDO  systemctl enable docker
        $SUDO  systemctl start docker
        
        echo "[+] Installing Rust (rustup)..."
        if ! command -v rustup >/dev/null 2>&1; then
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            # shellcheck disable=SC1091
            . "$HOME/.cargo/env"
        fi
        rustup update
        
        echo "[+] Installing uv python package manager..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
          
        echo "[+] Installing Go (if needed)..."
        if ! command -v go >/dev/null 2>&1 || ! go version | grep -qE 'go1.2[2-9]'; then
            $SUDO rm -rf /usr/local/go
            wget https://go.dev/dl/go1.24.4.linux-amd64.tar.gz
            tar -xvf go1.24.4.linux-amd64.tar.gz
            $SUDO mv go /usr/local/
            rm -f go*.tar.gz
            export PATH="$PATH:$HOME/go/bin"
        fi
        

        echo "[+] Installing jless (json viewer)"
        if ! command -v jless --verion >/dev/null 2>&1 ; then
            cargo install jless
        fi

        echo "[+] Installing entr (if needed for tmux auto-reload)..."
        if ! command -v entr >/dev/null 2>&1; then
            git clone https://github.com/eradman/entr.git
            cd entr
            ./configure
            sudo make test
            sudo make install
            cd ../
            rm -rf entr
        fi

        echo "[+] Installing nvm..."
        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash # Install nvm version 0.40.3
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
        if command -v nvm >/dev/null; then
            echo "nvm installation suceeded. installing version."
            echo -e "\t[!] Available nvm versions:"
            nvm list-remote       # avaiable versions
            echo -e "\t[+] Installing node v22..."
            nvm install v22.17.0  # install a version
            echo -e "\t[+] Installed versions:"
            nvm list              # View installed versions
            echo -e "\t[+] Selecting v22.17"
            nvm use v22.17.0 
        fi
        
        echo "[+] Done installing prerequisites!"
        
        printf "\n\n---------------------------------------------------\n\n"
        
        # MAIN INSTALLATIONS
        
        # Cargo ____________________________________
        echo "[+] Installing csvlens"
        cargo install csvlens
        
        echo "[+] Installing Dust..."
        cargo install du-dust
        
        echo "[+] Installing TPM (tmux plugin manager)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

        echo "[+] Installing fd..."
        cargo install fd-find

        echo "[+] Installing Yazi..."
        git clone https://github.com/sxyazi/yazi.git
        cd yazi
        cargo build --release --locked
        $SUDO  mv target/release/yazi target/release/ya /usr/local/bin/
        cd ..
        rm -rf yazi    



        # Go _______________________________________
        echo "[+] Installing lazysql..."
        go install github.com/jorgerojas26/lazysql@latest
        
        echo "[+] Installing eget..."
        go install github.com/zyedidia/eget@latest
        
        echo "[+] Installing lazygit..."
        go install github.com/jesseduffield/lazygit@latest

        echo "[+] Installing glow..."
        go install github.com/charmbracelet/glow/v2@latest



        # Other ___________________________________
        echo "[+] Installing ggh ssh manager..."
        curl https://raw.githubusercontent.com/byawitz/ggh/master/install/unix.sh | sh
        
        echo "[+] Installing lazydocker..."
        curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
        
        echo "[+] Installing Posting via uv..."
        uv tool install --python 3.13 posting

        echo "[+] Installing YouTube-downloader..."
        $SUDO  wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux -O /usr/local/bin/yt-dlp; $SUDO chmod +x /usr/local/bin/yt-dlp

        # echo "[+] Installing zioxide..."
        # curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh


        echo "[+] Installing llvm and related tools (clangd, cmake, etc)..."
        wget https://apt.llvm.org/llvm.sh
        chmod +x llvm.sh
        $SUDO  ./llvm.sh 20 all
        # or for latest stable release...
        # sudo ./llvm.sh all

        echo "[+] Installing Spotify Player..."    
        $SUDO apt-get install autotools-dev -y
        command -v pulseaudio >/dev/null 2>&1 || $SUDO apt install pulseaudio -y
        command -v pulseaudio-module-bluetooth >/dev/null 2>&1 || $SUDO apt install pulseaudio-module-bluetooth -y
        command -v pulseaudio-utils >/dev/null 2>&1 || $SUDO apt install pulseaudio-utils -y
        command -v pavucontrol >/dev/null 2>&1 || $SUDO apt install pavucontrol -y
        command -v libsixel-bin >/dev/null 2>&1 || $SUDO apt install libsixel-bin -y  # sixel encoder/decoder
        cargo install spotify_player --no-default-features --features pulseaudio-backend,media-control,sixel


        echo "[+] Installing various tools..."
        command -v 7zip  >/dev/null 2>&1 || $SUDO apt install 7zip  -y
        command -v poppler-utils  >/dev/null 2>&1 || $SUDO apt install poppler-utils  -y
        command -v imagemagick >/dev/null 2>&1 || $SUDO apt install imagemagick -y
        # command -v zoxide  >/dev/null 2>&1 || $SUDO apt install zoxide  -y
        # command -v fd-find  >/dev/null 2>&1 || $SUDO apt install fd-find  -y  # Installed with cargo above
        # echo "[+] Installing Latest Tmux..."    
        # $SUDO apt-get install autotools-dev -y
        # $SUDO apt-get install automake -y
        # command -v libevent-dev >/dev/null 2>&1 || $SUDO apt install libevent-dev -y
        # command -v bison >/dev/null 2>&1 || $SUDO apt install bison -y
        # $SUDO apt install libncurses5-dev 
        # command -v libncursesw5-dev >/dev/null 2>&1 || $SUDO apt install libncursesw5-dev -y
        #
        # git clone https://github.com/tmux/tmux.git
        # cd tmux
        # sh autogen.sh
        # ./configure --enable-sixel || { echo "Tmux configure failed"; }
        # make && $SUDO make install || { echo "Tmux build failed"; }
        # cd ../


        # echo "[+] Installing mpv..."
        # $SUDO  curl --output-dir /etc/apt/trusted.gpg.d -O https://apt.fruit.je/fruit.gpg
        # ADDITION="deb http://apt.fruit.je/ubuntu $(cat /etc/os-release | grep 'VERSION_CODENAME' | awk -F= '{print $2}' | xargs) mpv"
        # ADDITION="deb http://apt.fruit.je/ubuntu $(lsb_release -cs) mpv"
# echo $ADDITION | $SUDO  tee -a /etc/apt/sources.list.d/fruit.list
        # $SUDO  apt update
        # command -v mpv >/dev/null 2>&1 || $SUDO apt install mpv -y




    elif [ "$DISTRO_FAMILY" = "fedora" ]; then

        echo "TBD"

    elif [ "$DISTRO_FAMILY" = "arch" ]; then  

        AUR="yay -S --needed" 
        PACMAN="$SUDO pacman -S --needed"

        echo "# ──────────────────────────────────────────────────────────────────────────────────────────"
        echo "#        PACKAGE INSTALLATION | Part I: System update and setting up access to AUR"
        echo "# ──────────────────────────────────────────────────────────────────────────────────────────"

        # Update system
        yes | $SUDO pacman -Syu 

        # Essentials
        $PACMAN  base-devel           # build-essential: GCC/make/etc for system builds/AUR 
        yes | $PACMAN git 
        yes | $PACMAN go 
        yes | $PACMAN rustup  && rustup update

        # Yay installation (for AUR) (needs go)
        echo "[+] Installing yay..."
        git clone https://aur.archlinux.org/yay.git
        $SUDO chown -R ${CALLING_USER}:${CALLING_USER} yay && cd yay && makepkg -si  && cd ../


        # Note: Ones  I didn't add 'yes' to are usually interactive and expect a choice to be made
        #
        echo "[+] Installing core tools..."
        yes | $PACMAN curl  			# curl: Network downloader, system scripts rely on it 
        yes | $PACMAN wget  			# wget: Downloader, core for scripts 
        yes | $PACMAN tar    			# tar: Archiver, base system 
        yes | $PACMAN less  			# tar: Archiver, base system 
        yes | $PACMAN which 
        yes | $PACMAN xclip  			# xclip: Clipboard, X11 integration 
        yes | $PACMAN sed    			# sed: Text processor, base 
        yes | $PACMAN coreutils  		# coreutils: GNU utils, base 
        yes | $PACMAN glibc  			# libc6: Core C lib 
        yes | $PACMAN vim   			# vim-gtk3: GUI vim with GTK/X11 
        yes | $PACMAN zsh 
        yes | $PACMAN direnv 
        yes | $PACMAN unzip  			# unzip: Zip handler, base 
        yes | $PACMAN p7zip  			# p7zip-full: 7zip compression 
        # yes | $PACMAN 7zip
        
        echo "[+] Installing dev tools..."
        # System dev/build tools: Compilers/linkers for kernel modules/AUR; libs for system-wide linking.
        yes | $PACMAN make  			# make: Builder, base-devel 
        yes | $PACMAN gcc  			# gcc: Compiler, base-devel 
        yes | $PACMAN lib32-glibc  	# libc6-dev-i386: 32-bit libc dev 
        yes | $PACMAN binutils  		# binutils: Assembler/linker, base-devel 
        yes | $PACMAN bc  		    # bc: Calculator, base 
        yes | $PACMAN gettext  		# gettext: Localization, system 
        yes | $PACMAN bash  			# bash: Shell, base 
        yes | $PACMAN gawk  			# gawk: AWK, base 
        yes | $PACMAN llvm  
        yes | $PACMAN ufw  			# gawk: AWK, base 
        yes | $PACMAN uv  			# uv - python
        
        echo "[+] Installing  system/misc tools..."
        # Terminal/system extras: System integration like fonts/GUI/audio mounts.
        yes | $PACMAN sshfs  			# sshfs: FUSE mount, system fs 
        yes | $PACMAN sshpass  		# sshpass: SSH passwords, utils 
        yes | $PACMAN xsel  			# xsel: Clipboard, X11 
        yes | $PACMAN powerline-fonts	# fonts-powerline: Fonts for terminals 
        yes | $PACMAN pkgconf  		# pkg-config: Build helper
        $PACMAN  font-manager   		# font-manager: GUI fonts 

        
        echo "[+] Installing misc. tools..."
        # Misc tools: System info/process viewers.
        yes | $PACMAN fastfetch         # fastfetch: System info
        yes | $PACMAN htop              # htop: Process viewer 
        yes | $PACMAN openssl           # libssl-dev: Crypto
        yes | $PACMAN libxcb            # libxcb1-dev: XCB render, shape, etc
        yes | $PACMAN unixodbc          # unixodbc-dev: ODBC 
        yes | $PACMAN docker            # docker.io: Containers, system service 
        yes | $PACMAN docker-compose    # docker-compose-plugin: Docker compose 
        yes | $PACMAN entr              # entr ─ super useful file watcher
        yes | $PACMAN glow              # Markdown reader
        yes | $PACMAN fd                # → fd
        yes | $PACMAN yt-dlp            # YouTube downloader
        
        echo "[+] Installing media/sound-related pkgs..."
        # Sound-related: Audio libs/hardware accel integration.
        $PACMAN  alsa-lib --neded       # libasound2-dev: ALSA 
        $PACMAN ffmpeg                  # ffmpeg: Multimedia 
        yes | $PACMAN playerctl         # playerctl: Media control 
        yes | $PACMAN libass            # libass9: Subtitles 
        yes | $PACMAN libbluray         # libbluray2: Blu-ray 
        yes | $PACMAN libcaca           # libcaca0: Graphics 
        yes | $PACMAN libcdio           # libcdio-cdda2/libcdio-paranoia2/libcdio19: CDIO        
        yes | $PACMAN rubberband        # librubberband2: Audio stretch 
        yes | $PACMAN dbus              # libdbus-1-dev: Bus 
        yes | $PACMAN ncurses           # libncursesw5-dev: Curses wide 
        yes | $PACMAN poppler           # poppler-utils (pdf → text/images utilities including pdftoppm, pdftohtml…)
        yes | $PACMAN imagemagick


        echo "[+] Installing Spotify Player dependencies..."


        # 1. Modern / recommended (PipeWire + official package)
        $PACMAN libsixel spotify-player pavucontrol   # pavucontrol still works via pipewire-pulse

        # ────────────────────────────────────────────────
        # 2. OR if you insist on PulseAudio backend:
        # sudo pacman -S --needed pulseaudio pulseaudio-bluetooth pavucontrol libsixel

        # Then (if not using the official package):
        # cargo install spotify_player --no-default-features --features pulseaudio-backend,media-control,sixel --force

        # 3. Or if you prefer building from source with your chosen features:
        #    (most common choice today = gstreamer backend = native PipeWire support)
        # cargo install spotify_player --no-default-features --features "gstreamer-backend,media-control,sixel,image,notify,lyric-finder"
        # ────────────────────────────────────────────────
        echo "[+] Done!"
        echo ""
        echo "Notes:"
        echo "  • spotify_player should now be in ~/.cargo/bin/spotify_player"
        echo "  • Make sure ~/.cargo/bin is in your PATH"
        echo "  • PulseAudio should be running (usually started automatically via pipewire-pulse or systemd)"
        echo "  • If you use PipeWire instead of PulseAudio, you may want the pipewire-pulse + wireplumber stack"
        echo "    and possibly pipewire-alsa pipewire-jack instead of pure pulseaudio packages."


        # PipeWire check        
        if systemctl --user is-active pipewire >/dev/null; then
            yes | $PACMAN pipewire      # libpipewire-0.3-0: PipeWire lib 
        fi
        
        echo "[+] Installing graphics-related pkgs..."
        # Vulkan/graphics: GPU driver integration.
        yes | $PACMAN mesa-utils        # mesa-utils vulkan-tools: Graphics tools 
        

        echo "# ──────────────────────────────────────────────────────────────────────────────────────────"
        echo "#        PACKAGE INSTALLATION | Part II: Installing AUR pkgs (or potential AUR pkgs)"
        echo "# ──────────────────────────────────────────────────────────────────────────────────────────"

        echo "[+] Installing AUR pkgs (or potential AUR pkgs)..."
        $AUR  zimg                      # libzimg2: Image scaling 
        $AUR  mlocate                   # locate: File indexer, system db 
        $AUR  jless                     # json viewer

        # Cargo-based tools ─ many have AUR packages (faster, no need to keep cargo cache)
        $PACMAN csvlens        || $AUR csvlens      # very popular
        $PACMAN dust           || $AUR du-dust      # → dust
        $PACMAN yazi           || $AUR yazi         # excellent file manager, now in community/extra in recent years

        # Go-based tools ─ most in AUR or official repos
        $PACMAN lazygit        || $AUR lazygit              # official repo now
        $AUR lazysql           # almost always AUR
        $AUR eget              # usually AUR
        $AUR ggh               # SSH session manager – AUR

        # lazydocker → usually AUR or curl script still works
        $AUR lazydocker        || curl -sSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

        # posting (HTTP client – python) – now has AUR package
        $AUR posting           || uv tool install --python 3.13 posting   # fallback

        # node version manager
        $AUR  nvim                         

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
        $SUDO  systemctl enable docker
        $SUDO  systemctl start docker


    fi


    printf "\n\n\n"

    echo "# ──────────────────────────────────────────────────────────────────────────────────────────"
    echo "#        PACKAGE INSTALLATION | Part III: Installing personal bins and running checks"
    echo "# ──────────────────────────────────────────────────────────────────────────────────────────"

    echo "[+] Installing workflow-specific programs (from /usr/local/bin)"
    $SUDO cp -f -v ./config/usr_local_bin/* /usr/local/bin/
    
    echo "[+] Manually Installing any missing packages..."
    
    if ! command -v nvim >/dev/null 2>&1; then
        printf "[+] Installing latest neovim stable release...\n\n"
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
        $SUDO rm -rf /opt/nvim
        $SUDO tar -C /opt -xzf nvim-linux-x86_64.tar.gz
        # echo "→ Consider adding /opt/nvim-linux-x86_64/bin to your PATH"
        # echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> $HOME/.zshrc
        # rm nvim-linux-x86_64.tar.gz
        # Already aadded to PTH in .zshrc - just export for now so we can use it now
        export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
    fi

    # Download and install lazygit
    if ! command -v lazygit >/dev/null 2>&1; then
        printf "[+] Installing lazygit...\n\n"
        LAZYGIT_VERSION='0.40.2'
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
        && tar xf lazygit.tar.gz lazygit \
        && $SUDO mv -f lazygit /usr/local/bin/ \
        && rm lazygit.tar.gz
    fi
    

fi



# ────────────────────────────────────────────────
#             CONFIG COPY (distro agnostic)
# ────────────────────────────────────────────────

if [ "$1" = "full" -o "$1" = "configonly" ]; then

    echo "# ────────────────────────────────────────────────"
    echo "#        CONFIG INSTALLATION "
    echo "# ────────────────────────────────────────────────"

    printf "[+] Home: $HOME\n"
    
    # Execute from the dir the script is in
    cd $(dirname "$0") && cd ../ && pwd || exit

    PWD=$(pwd)
    printf "[+] PWD: $PWD\n"
 
    if [ ! -d $HOME/.config/ ]; then
        mkdir -p $HOME/.config/
    fi
    
    # Sync local config files with cloned repo so i can push up my changes
    cp -f -v ./config/.bash_aliases  $HOME/
    cp -f -v ./config/.bash_git  $HOME/
    cp -f -v ./config/.bash_pbx  $HOME/
    cp -f -v ./config/.bash_utils  $HOME/
    cp -f -v ./config/.bashrc  $HOME/
    cp -f -v ./config/.p10k.zsh  $HOME/
    cp -f -v ./config/.tmux.conf  $HOME/
    cp -f -v ./config/.vimrc  $HOME/
    cp -f -v ./config/.zshrc   $HOME/
    cp -f -v ./config/.zsh_customizations  $HOME/
    cp -f -v ./config/.tmux_init.sh  $HOME/
    cp -f -v ./config/.wezterm.lua  $HOME/

    # __________ NVIM __________
    if [ -d $HOME/.config/nvim/ ]; then
        mkdir -p $HOME/.config/nvim
    fi

    # [.config] If backup folder exists remove it so we can overwrite it
    if [ -d $HOME/.config/nvim-backup ]; then
        rm -rf $HOME/.config/nvim-backup
    fi
    mv $HOME/.config/nvim $HOME/.config/nvim-backup	    
    cp -v -r ./config/.config/nvim  $HOME/.config/

    # [.local] If backup folder exists remove it so we can overwrite it
    if [ -d ~/.local/share/nvim-backup ]; then
        rm -rf ~/.local/share/nvim-backup
    fi
    mv ~/.local/share/nvim ~/.local/share/nvim-backup

    # Vim
    if [ -d $HOME/.vim/ ]; then
        mkdir -p $HOME/.vim
    fi
    cp -f -v -r ./config/.config/nvim/colors  $HOME/.vim/


    # __________ Spotify-player ___________
    if [ ! -d $HOME/.config/spotify-player/ ]; then
        mkdir -p $HOME/.config/spotify-player
    fi
    cp -v -r ./config/.config/spotify-player  $HOME/.config/
    
    cp -v -f -r ./config/.config/lazygit  $HOME/.config/

    
    # ---------------------------------------------------------------------
    # Copy starship profile
    cp -v -f -r ./config/.config/starship.toml  $HOME/.config/

    # Copy Yazi config
    cp -v -f -r ./config/.config/yazi  $HOME/.config/

    # Install custom shell scripts and exes
    sudo cp -v -f -r ./config/usr_local_bin/* /usr/local/bin/


    # 'noshellswitch' means we're just updating our local files - no need to install ohmyzsh/fonts/powerline
    if [ "$2" != "noshellswitch" ]; then

        # Install fonts
        printf "[+] Installing fonts..."
        unzip -o ./fonts/JetBrainsMonoNerdFont-REGULARFONTSONLY.zip  -d ./fonts/
        sudo cp ./fonts/*.ttf /usr/share/fonts/truetype/

        # for file in $(find ./fonts/ -type f -iname "*.ttf")
        # do
        #     echo $file
        # done

        # This removes powerline (since powerline install in ~/.oh-my-zsh) so make sure this is before powerline install
        if [ -d $HOME/.oh-my-zsh ]; then
            rm -rf $HOME/.oh-my-zsh
        fi

        printf "[+] Installing oh-my-zsh...\n\n"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        # If powerline isn't installed, oh-my-zsh+powerline should be installed for installed for good measure - and shell updated
        if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k/ ]; then

            printf "[+] Installing powerlevel10k...\n\n"
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
            # sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        
        fi

    fi

    echo "[+] Configuration files copied!"


    if which zsh >/dev/null 2>&1; then
    
        # Installing oh-my-zsh can wipe out our ~/.zshrc - let's copy it over again in case
        cd $(dirname "$0") && cd ../ && pwd || exit

        cp -v ./config/.zshrc   $HOME/

        current_shell=$(getent passwd "$USER" | cut -d: -f7 || echo "")

        case "$current_shell" in
            *zsh)
                echo "→ Login shell is already zsh – no change needed"
                ;;
            *)
                echo "[+] Current login shell: ${current_shell:-not found}"
                echo "[+] Changing login shell to zsh... (may prompt for password)"
                
                if chsh -s "$(command -v zsh)"; then
                    echo "→ Login shell updated (takes effect in new sessions)"
                else
                    echo "→ chsh failed – try running it manually"
                fi
                ;;
        esac

        cp -v ./config/.zshrc  $HOME/
        echo "→ You may need to log out/in or run: source ~/.zshrc (or ~/.bashrc)"
        echo "→ Some tools require fonts (Nerd Fonts) or extra setup"

        if [ "$2" != "noshellswitch" ]; then
            zsh
        fi

    fi

fi


printf "\n\n\n"
echo "# ────────────────────────────────────────────────"
echo "#        FINISHED! "
echo "# ────────────────────────────────────────────────"
printf "\n\n\n"




