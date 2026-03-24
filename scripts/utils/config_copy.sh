
echo "# ────────────────────────────────────────────────"
echo "#        CONFIG INSTALLATION "
echo "# ────────────────────────────────────────────────"

printf "[+] Home: $HOME | PWD: $PWD\n"

# Set pwd to project root
cd $(dirname "$0") && cd ../ && cd ../ && pwd || exit

PWD=$(pwd)
printf "[+] PWD: $PWD\n"


# # Sync local config files with cloned repo so i can push up my changes
cp -f -v ./dotfiles/.bash_aliases  $HOME/
cp -f -v ./dotfiles/.bash_git  $HOME/
cp -f -v ./dotfiles/.bash_pbx  $HOME/
cp -f -v ./dotfiles/.bash_utils  $HOME/
cp -f -v ./dotfiles/.bashrc  $HOME/
cp -f -v ./dotfiles/.p10k.zsh  $HOME/
cp -f -v ./dotfiles/.tmux.conf  $HOME/
cp -f -v ./dotfiles/.vimrc  $HOME/
cp -f -v ./dotfiles/.zshrc   $HOME/
cp -f -v ./dotfiles/.zsh_customizations  $HOME/
cp -f -v ./dotfiles/.tmux_init.sh  $HOME/
cp -f -v ./dotfiles/.wezterm.lua  $HOME/

# __________ Spotify-player ___________
if [ ! -d $HOME/.config/spotify-player/ ]; then
    mkdir -p $HOME/.config/spotify-player
fi
cp -v -r ./dotfiles/.config/spotify-player  $HOME/.config/

cp -v -f -r ./dotfiles/.config/lazygit  $HOME/.config/


# ---------------------------------------------------------------------
# Copy starship profile
cp -v -f -r ./dotfiles/.config/starship.toml  $HOME/.config/

# Copy Yazi config
cp -v -f -r ./dotfiles/.config/yazi  $HOME/.config/

# Install custom shell scripts and exes
sudo cp -v -f -r ./dotfiles/usr_local_bin/* /usr/local/bin/


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


