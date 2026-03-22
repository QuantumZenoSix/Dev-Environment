#!/bin/sh
# Installation of packages and copying of config files

# set -euo pipefail  # safer bash scripting

INSTALL_TYPE=$1
INSTALL_SUBTYPE=$2
OPTION=$3

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

sync_nvim_files(){

    if [ -d $HOME/.config/nvim/ ]; then
        mkdir -p $HOME/.config/nvim
    fi

    # [.config] If backup folder exists remove it so we can overwrite it
    if [ -d $HOME/.config/nvim-backup ]; then
        rm -rf $HOME/.config/nvim-backup
    fi

    # Save copy of any existing nvim files in case we need to restore
    [ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$HOME/.config/nvim-backup"

    # Copy nvim files
    cp -v -r ./config/.config/nvim  $HOME/.config/

    # [.local files (nvim cache) ] If backup folder exists move it so we can restore if needed and so that it leaves the .local dir empty to empty the cache
    [ -d "$HOME/.local/share/nvim-backup" ] && rm -rf "$HOME/.local/share/nvim-backup"
    [ -d "$HOME/.local/share/nvim" ] && mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim-backup"

    echo "[+] Nvim files copied!"

    # Vim
    cp -f -v ./config/.vimrc  $HOME/

    echo "[+] Vim files copied!"

}



###########
# START   #
###########


# ────────────────────────────────────────────────
#        PACKAGE INSTALLATION (skip if configonly)
# ────────────────────────────────────────────────
# Unless we're explicitly calling to only copy the configs, then let's start installing (modes: full, installonly)
if [ "${INSTALL_TYPE}" != "configonly" ]; then

    if [ "$DISTRO_FAMILY" = "debian" ]; then

        . ./pkg_install_debian.sh.sh

    elif [ "$DISTRO_FAMILY" = "arch" ]; then  

        . ./pkg_install_arch.sh.sh

    elif [ "$DISTRO_FAMILY" = "fedora" ]; then

        echo "Yeah...about.. that... [TBD]"

    fi

    echo "[+] Installing workflow-specific programs (from /usr/local/bin)"
    $SUDO cp -f -v ./config/usr_local_bin/* /usr/local/bin/

fi




# ────────────────────────────────────────────────
#             CONFIG COPY (distro agnostic)
# ────────────────────────────────────────────────

if [ "${INSTALL_TYPE}" = "full" -o "${INSTALL_TYPE}" = "configonly" ]; then

    ./config_copy.sh
fi


printf "\n\n\n"
echo "# ────────────────────────────────────────────────"
echo "#        FINISHED! "
echo "# ────────────────────────────────────────────────"
printf "\n\n\n"
echo "→ You may need to log out/in or simply run 'zsh'"




