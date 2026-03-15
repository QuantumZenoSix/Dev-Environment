#!/bin/sh
# Installation of packages and copying of config files

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


##### NVIM-ONLY
if [ "$1" = "nvimonly" ]; then
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

    echo "[+] Nvim files copied!"

    # Vim
    cp -f -v ./config/config/.vimrc  $HOME/
    if [ -d $HOME/.vim/ ]; then
        mkdir -p $HOME/.vim
    fi
    cp -f -v -r ./config/nvim/colors  $HOME/.vim/
    echo "[+] Vim files copied!"

    exit
fi

##### CONFIG
# ------------------------------------------------------------------------
if [ "$1" = "full" -o "$1" = "configonly" ]; then
    
    printf "[+] Home: $HOME\n"
    
    # Execute from the dir the script is in
    cd "$(dirname "$0")" || exit

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
    # Copy Yazi config
    cp -v -f -r ./config/.config/yazi  $HOME/.config/


    # Install custom shell scripts and exes
    sudo cp -v -f -r ./config/usr_local_bin/* /usr/local/bin/

    # If powerline isn't installed, oh-my-zsh+powerline should be installed for installed for good measure - and shell updated
    if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k/ ]; then

        # This removes powerline (since powerline install in ~/.oh-my-zsh) so make sure this is before powerline install
        if [ -d $HOME/.oh-my-zsh ]; then
            rm -rf $HOME/.oh-my-zsh
        fi

        printf "[+] Installing oh-my-zsh...\n\n"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        printf "[+] Installing powerlevel10k...\n\n"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
        # sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        
        printf "[+] Setting default shell...\n\n"
        if which zsh >/dev/null 2>&1; then
        
            cd "$(dirname "$0")"
            cp -v ./config/.zshrc   $HOME/
            chsh -s $(which zsh)
            printf "Shell set to: $(grep ${CALLING_USER} /etc/passwd | awk -F: '{print $7}')\n"
            # Installing oh-my-zsh can wipe out our ~/.zshrc - let's copy it over again in case
            cp -v ./config/.zshrc   $HOME/
            zsh
        fi

    fi

fi

##### PACKAGE INSTALLATION
# ------------------------------------------------------------------------
# Unless we're explicitly calling to only copy the configs, then let's start installing
if [ "$1" != "configonly" ]; then

    if ! command -v apt >/dev/null || ! grep -qi ubuntu /etc/os-release; then
        echo "This script requires an Ubuntu-based system"
        exit 1
    fi
    
    # $SUDO apt update || { echo "Failed to update package lists"; exit 1; }
    $SUDO apt update 
    
    echo "[+] Installing essential core packages..."    # Not essential per se, but essentials for my workflow,enchancements, and customizations
    $SUDO  apt install python3 perl wget tar make gcc unzip git git-all xclip  build-essential curl locate cmake libstdc++6 vim-gtk3 libc6-dev libc6-dev-i386 nasm binutils libc6 bc sed coreutils cargo pandoc nodejs npm ninja-build gettext -y
    
    echo "[+] Installing extras..."
    $SUDO  apt install zsh tmux p7zip-full jq python3-pygments sshfs sshpass xsel lua5.3 fonts-powerline bash gawk pkg-config mssql-tools -y

    echo "[+] Installing various dependencies..."

    $SUDO  apt install pkg-config libssl-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev libssl-dev crossbuild-essential-arm64 clang -y

    echo "[+] Installing various dependencies (fragile)..." # Packages which not not be found in older package repos
    $SUDO  apt fzf ripgrep unixODBC-devel docker.io docker-compose-plugin -y
    
    echo "[+] Installing various sound-related dependencies..."
    $SUDO add-apt-repository ppa:ubuntuhandbook1/ffmpeg6
    $SUDO apt install playerctl libasound2-dev ffmpeg libass9 libbluray2 libcaca0 libcdio-cdda2 libcdio-paranoia2 libcdio19 librubberband2 libzimg2 libdbus-1-dev libncursesw5-dev libpulse-dev libssl-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
    if systemctl --user is-active pipewire >/dev/null; then
        echo "Using PipeWire, installing specific dependencies..."
        $SUDO apt install libpipewire-0.3-0  -y
    fi
    
    echo -e "\n[+] ______ Installing manual installs _______"            # Software that isn't installed via a distro's package manager (may contain fixed versions). The order below is important.
    
    # PRE-REQUISITES
    echo "[+] (optional) installing vulkan graphics drivers..."
    $SUDO apt install mesa-utils vulkan-tools -y

    echo "[+] Enabling docker service..."
    $SUDO  systemctl enable docker
    $SUDO  systemctl start docker
    
    echo "[+] Installing Rust/Rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
    
    echo "[+] Installing uv python package manager..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
      
    echo "[+] Installing Go..."
    rm -rf /usr/local/go
    wget https://go.dev/dl/go1.24.4.linux-amd64.tar.gz -O go1.24.4.linux-amd64.tar.gz
    tar -xvf go1.24.4.linux-amd64.tar.gz
    $SUDO  mv go /usr/local/
    rm -rf go1.24.4.linux-amd64.tar.gz
    
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
    echo "[+] Installing ggh ssh manager..."
    curl https://raw.githubusercontent.com/byawitz/ggh/master/install/unix.sh | sh
    
    echo "[+] Installing tere..."
    cargo install tere
    
    echo "[+] Installing csvlens"
    cargo install csvlens
    
    echo "[+] Installing Dust..."
    cargo install du-dust
    
    echo "[+] Installing YouTube-downloader..."
    $SUDO  wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux -O /usr/local/bin/yt-dlp; $SUDO chmod +x /usr/local/bin/yt-dlp

    echo "[+] Installing lazysql..."
    go install github.com/jorgerojas26/lazysql@latest
    
    echo "[+] Installing Tufw (UFW GUI)..."
    $SUDO  wget https://github.com/peltho/tufw/releases/download/v0.2.4/tufw_0.2.4_linux_amd64.deb -O ./tufw_0.2.4_linux_amd64.deb
    $SUDO  apt install ./tufw_0.2.4_linux_amd64.deb -y
    $SUDO  rm ./tufw_0.2.4_linux_amd64.deb
    
    echo "[+] Installing eget..."
    go install github.com/zyedidia/eget@latest
    
    echo "[+] Installing lazygit..."
    go install github.com/jesseduffield/lazygit@latest
    
    echo "[+] Installing lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    
    echo "[+] Installing Posting via uv..."
    uv tool install --python 3.13 posting
    
    echo "[+] Installing mpv..."
    $SUDO  curl --output-dir /etc/apt/trusted.gpg.d -O https://apt.fruit.je/fruit.gpg
    # ADDITION="deb http://apt.fruit.je/ubuntu $(cat /etc/os-release | grep 'VERSION_CODENAME' | awk -F= '{print $2}' | xargs) mpv"
    ADDITION="deb http://apt.fruit.je/ubuntu $(lsb_release -cs) mpv"
    echo $ADDITION | $SUDO  tee -a /etc/apt/sources.list.d/fruit.list
    $SUDO  apt update
    $SUDO  apt install mpv -y
    
    echo "[+] Installing llvm and related tools (clangd, cmake, etc)..."
    wget https://apt.llvm.org/llvm.sh
    chmod +x llvm.sh
    $SUDO  ./llvm.sh 20 all
    # or for latest stable release...
    # sudo ./llvm.sh all
    
    echo "[+] Installing Yazi..."
    $SUDO  apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
    
    git clone https://github.com/sxyazi/yazi.git
    cd yazi
    cargo build --release --locked
    $SUDO  mv target/release/yazi target/release/ya /usr/local/bin/
    cd ..
    rm -rf yazi

    echo "[+] Installing Latest Tmux..."    
    $SUDO apt-get install autotools-dev -y
    $SUDO apt-get install automake -y
    $SUDO apt install libevent-dev -y
    $SUDO apt install bison -y
    $SUDO apt install libncurses5-dev libncursesw5-dev -y
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure --enable-sixel || { echo "Tmux configure failed"; }
    make && $SUDO make install || { echo "Tmux build failed"; }
    cd ../

    echo "[+] Installing Spotify Player..."    
    $SUDO apt-get install autotools-dev -y
    $SUDO apt install pulseaudio pulseaudio-module-bluetooth pulseaudio-utils pavucontrol
    $SUDO apt install libsixel-bin -y  # sixel encoder/decoder
    cargo install spotify_player --no-default-features --features pulseaudio-backend,media-control,sixel


    # __________________ WORKFLOW ___________
    echo -e "\n\n\n[+] ______ Finished main packages ______\n\n\n"
    echo "[+] Installing workflow-specific programs"
    $SUDO cp -f -v ./config/usr_local_bin/* /usr/local/bin/
    
    echo "[+] Installing any missing packages..."
    
    printf "[+] Removing stale lockfiles...\n\n"
    $SUDO rm -f /var/lib/dpkg/lock-frontend
    $SUDO rm -f /var/lib/dpkg/lock

    if ! command -v nvim >/dev/null 2>&1; then
        printf "[+] Installing latest neovim stable release...\n\n"
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
        $SUDO rm -rf /opt/nvim
        $SUDO tar -C /opt -xzf nvim-linux-x86_64.tar.gz
        # echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> $HOME/.zshrc
        export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
    fi

    # Download and install lazygit
    if ! command -v lazygit >/dev/null 2>&1; then
        printf "[+] Installing lazygit...\n\n"
        LAZYGIT_VERSION='0.40.2'
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
        && tar xf lazygit.tar.gz lazygit \
        && mv -f lazygit /usr/local/bin/ \
        && rm lazygit.tar.gz
    fi
    
fi




echo "Done!"

