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
else
    echo "Error: Unsupported distribution."
    echo "       Detected ID=$ID  ID_LIKE=$ID_LIKE"
    echo "       This script currently supports only Debian-family and Fedora-family systems."
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

    printf "\n\n"
    echo "# ────────────────────────────────────────────────────────────────────────"
    echo "#        PACKAGE INSTALLATION (Part I: Core install from package manager)"
    echo "# ────────────────────────────────────────────────────────────────────────"
    printf "\n\n"

    if [ "$DISTRO_FAMILY" = "debian" ]; then


        if ! command -v apt >/dev/null || ! grep -qi ubuntu /etc/os-release; then
            echo "This script requires an Ubuntu-based system"
            exit 1
        fi
        
        echo "[+] Updating package lists (Debian/Ubuntu)..."
        # $SUDO apt update || { echo "Failed to update package lists"; exit 1; }
        $SUDO apt update 
        
        echo "[+] Installing essential core packages..."    # Not essential per se, but essentials for my workflow,enchancements, and customizations
        $SUDO apt install curl -y
        $SUDO apt install wget -y
        $SUDO apt install tar -y
        $SUDO apt install unzip -y
        $SUDO apt install xclip -y
        $SUDO apt install build-essential -y
        $SUDO apt install locate -y
        $SUDO apt install sed -y
        $SUDO apt install coreutils -y
        $SUDO apt install vim-gtk3 -y
        $SUDO apt install libc6 -y
        $SUDO apt install p7zip-full -y

        # Languages
        echo "[+] Installing dev related packages..."    # Not essential per se, but essentials for my workflow,enchancements, and customizations
        $SUDO apt install python3 -y
        $SUDO apt install perl -y
        $SUDO apt install make -y
        $SUDO apt install gcc -y
        $SUDO apt install git-all -y
        $SUDO apt install cmake -y
        $SUDO apt install libstdc++6 -y
        $SUDO apt install libc6-dev -y
        $SUDO apt install libc6-dev-i386 -y
        $SUDO apt install nasm -y
        $SUDO apt install binutils -y
        $SUDO apt install bc -y
        $SUDO apt install cargo -y
        $SUDO apt install pandoc -y
        $SUDO apt install nodejs -y
        $SUDO apt install npm -y
        $SUDO apt install ninja-build -y
        $SUDO apt install gettext -y
        $SUDO apt install pipx && pipx ensurepath
        $SUDO apt install lua5.3 -y
        $SUDO apt install jq -y
        $SUDO apt install python3-pygments -y
        $SUDO apt install bash -y
        $SUDO apt install gawk -y
        
        echo "[+] Installing terminal/workflow extras..."
        $SUDO apt install zsh -y
        $SUDO apt install tmux -y
        $SUDO apt install sshfs -y
        $SUDO apt install sshpass -y
        $SUDO apt install xsel -y
        $SUDO apt install tree -y
        $SUDO apt install fonts-powerline -y
        $SUDO apt install pkg-config -y
        $SUDO apt install mssql-tools --ignore-missing -y   # Requires MicrSoft repo
        $SUDO apt install font-manager -y # GUI
        $SUDO apt install direnv -y
        $SUDO apt install clang -y
        
        echo "[+] Installing misc tools..."
        # Fastfetch
        $SUDO add-apt-repository ppa:zhangsongcui3371/fastfetch
        $SUDO apt update
        $SUDO apt install fastfetch -y

        $SUDO apt install htop -y

        echo "[+] Installing various dependencies..."
        $SUDO apt install pkg-config -y
        $SUDO apt install libssl-dev -y
        $SUDO apt install libxcb1-dev -y
        $SUDO apt install libxcb-render0-dev -y
        $SUDO apt install libxcb-shape0-dev -y
        $SUDO apt install libxcb-xfixes0-dev -y
        $SUDO apt install crossbuild-essential-arm64 -y

        echo "[+] Installing various dependencies (fragile)..." # Packages which may not be found in older package repos
        $SUDO apt install fzf -y
        $SUDO apt install ripgrep -y
        $SUDO apt install unixodbc-dev -y
        $SUDO apt install docker.io -y
        $SUDO apt install docker-compose-plugin -y
        
        echo "[+] Installing various sound-related dependencies..."
        $SUDO add-apt-repository ppa:ubuntuhandbook1/ffmpeg6
        $SUDO apt install playerctl -y
        $SUDO apt install libasound2-dev -y
        $SUDO apt install ffmpeg -y
        $SUDO apt install libass9 -y
        $SUDO apt install libbluray2 -y
        $SUDO apt install libcaca0 -y
        $SUDO apt install libcdio-cdda2 -y
        $SUDO apt install libcdio-paranoia2 -y
        $SUDO apt install libcdio19 -y
        $SUDO apt install librubberband2 -y
        $SUDO apt install libzimg2 -y
        $SUDO apt install libdbus-1-dev -y
        $SUDO apt install libncursesw5-dev -y
        $SUDO apt install libpulse-dev -y
        $SUDO apt install libssl-dev -y
        $SUDO apt install libxcb1-dev -y
        $SUDO apt install libxcb-render0-dev -y
        $SUDO apt install libxcb-shape0-dev -y
        $SUDO apt install libxcb-xfixes0-dev -y

        if systemctl --user is-active pipewire >/dev/null; then
            echo "Using PipeWire, installing specific dependencies..."
            $SUDO apt install libpipewire-0.3-0  -y
        fi

        echo "[+] (optional) installing vulkan graphics drivers..."
        $SUDO apt install mesa-utils vulkan-tools -y


    elif [ "$DISTRO_FAMILY" = "fedora" ]; then

        echo "TBD"

    fi


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
    echo "[+] Installing ggh ssh manager..."
    curl https://raw.githubusercontent.com/byawitz/ggh/master/install/unix.sh | sh
    
    echo "[+] Installing zioxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    
    echo "[+] Installing csvlens"
    cargo install csvlens
    
    echo "[+] Installing Dust..."
    cargo install du-dust
    
    echo "[+] Installing TPM (tmux plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    echo "[+] Installing fd..."
    cargo install fd-find

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

    echo "[+] Installing glow..."
    go install github.com/charmbracelet/glow/v2@latest

    echo "[+] Installing lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    
    echo "[+] Installing Posting via uv..."
    uv tool install --python 3.13 posting




    echo "# ────────────────────────────────────────────────"
    echo "#        PACKAGE INSTALLATION (Part III: Additional install from package manager)"
    echo "# ────────────────────────────────────────────────"
    # This third step must remain here as some of the programs in step 2 are required for this step


    if [ "$DISTRO_FAMILY" = "debian" ]; then

        # echo "[+] Installing mpv..."
        # $SUDO  curl --output-dir /etc/apt/trusted.gpg.d -O https://apt.fruit.je/fruit.gpg
        # ADDITION="deb http://apt.fruit.je/ubuntu $(cat /etc/os-release | grep 'VERSION_CODENAME' | awk -F= '{print $2}' | xargs) mpv"
        # ADDITION="deb http://apt.fruit.je/ubuntu $(lsb_release -cs) mpv"
# echo $ADDITION | $SUDO  tee -a /etc/apt/sources.list.d/fruit.list
        # $SUDO  apt update
        # $SUDO  apt install mpv -y
        
        echo "[+] Installing llvm and related tools (clangd, cmake, etc)..."
        wget https://apt.llvm.org/llvm.sh
        chmod +x llvm.sh
        $SUDO  ./llvm.sh 20 all
        # or for latest stable release...
        # sudo ./llvm.sh all
        
        echo "[+] Installing various tools..."
        $SUDO  apt install 7zip  -y
        $SUDO  apt install poppler-utils  -y
        $SUDO  apt install zoxide  -y
        $SUDO  apt install imagemagick -y
        # $SUDO  apt install fd-find  -y  # Installed with cargo above
        
        echo "[+] Installing Yazi..."
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
        $SUDO apt install libncurses5-dev 
        $SUDO apt install libncursesw5-dev -y

        git clone https://github.com/tmux/tmux.git
        cd tmux
        sh autogen.sh
        ./configure --enable-sixel || { echo "Tmux configure failed"; }
        make && $SUDO make install || { echo "Tmux build failed"; }
        cd ../

        echo "[+] Installing Spotify Player..."    
        $SUDO apt-get install autotools-dev -y
        $SUDO apt install pulseaudio -y
        $SUDO apt install pulseaudio-module-bluetooth -y
        $SUDO apt install pulseaudio-utils -y
        $SUDO apt install pavucontrol -y
        $SUDO apt install libsixel-bin -y  # sixel encoder/decoder
        cargo install spotify_player --no-default-features --features pulseaudio-backend,media-control,sixel


        # Keep at end
        printf "[+] Removing stale lockfiles...\n\n"
        $SUDO rm -f /var/lib/dpkg/lock-frontend
        $SUDO rm -f /var/lib/dpkg/lock


    elif [ "$DISTRO_FAMILY" = "fedora" ]; then

        echo "TBD"
    fi

    printf "\n\n\n"

    echo "# ────────────────────────────────────────────────"
    echo "#        PACKAGE INSTALLATION (Part IV: Workflow setup)"
    echo "# ────────────────────────────────────────────────"

    echo "[+] Installing workflow-specific programs (from /usr/local/bin)"
    $SUDO cp -f -v ./config/usr_local_bin/* /usr/local/bin/
    
    echo "[+] Installing any missing packages..."
    
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
    cp -f -v ./config/.wezterm_wsl.lua  $HOME/.wezterm.lua

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




