
echo "# ────────────────────────────────────────────────"
echo "#        CONFIG INSTALLATION "
echo "# ────────────────────────────────────────────────"

printf "[+] Home: $HOME | PWD: $PWD\n"

# Set pwd to project root
cd $(dirname "$0") && cd ../ && cd ../ && pwd || exit

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


# 'noupdateshellenv' means we're just updating our local files - no need to install ohmyzsh/fonts/powerline
if [ "${INSTALL_SUBTYPE}" != "noupdateshellenv" ]; then

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

    # Set pwd to project root
    cd $(dirname "$0") && cd ../ && cd ../ && pwd || exit

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

    # Don't open new zsh shell
    # if [ "${INSTALL_SUBTYPE}" != "noupdateshellenv" -a "${INSTALL_SUBTYPE}" != "os-pop" ]; then
    #     zsh
    # fi

fi
