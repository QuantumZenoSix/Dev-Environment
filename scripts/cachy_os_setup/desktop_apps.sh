#!/usr/bin/env bash

# CachyOS Post-Install Recommended Tasks Script
# Run with: bash this_script.sh   (or make executable: chmod +x script.sh && ./script.sh)
# Review each section before running!

set -euo pipefail

echo "============================================================="
echo " CachyOS Post-Install Setup Script"
echo "============================================================="
echo "Current date: $(date)"
echo "This will:"
echo "  - Update the full system"
echo "  - Re-run hardware detection (chwd) for GPU drivers"
echo "  - Install common useful packages / codecs / fonts"
echo "  - Set up basic firewall (ufw)"
echo "  - Install gaming meta-packages (optional)"
echo "  - Some performance/QoL tweaks"
echo ""
read -p "Press Enter to continue (or Ctrl+C to cancel) ..."

# 1. Full system update (including AUR if paru is used later)
echo -e "\n1. Updating the system (pacman -Syu) ..."
sudo pacman -Syu --noconfirm

# 2. Hardware detection → ensures correct GPU drivers (NVIDIA/AMD/Intel)
#    chwd -a is safe to run again; it usually does nothing if already configured
echo -e "\n2. Running CachyOS hardware detection (chwd) for drivers ..."
sudo chwd -a

# Quick GPU status check (informational)
echo -e "\nGPU / driver quick check:"
lspci -k | grep -EA3 'VGA|3D|Display' || true
glxinfo | grep "OpenGL renderer" || echo "glxinfo not found yet"

# For NVIDIA users — extra check/fix if proprietary driver seems missing
if lspci | grep -i nvidia >/dev/null; then
    echo -e "\nNVIDIA GPU detected → checking proprietary driver status ..."
    if ! pacman -Qs nvidia >/dev/null; then
        echo "→ Proprietary NVIDIA driver not found. Installing stable branch via chwd..."
        sudo chwd -i nvidia  # or try: sudo chwd -i nvidia-open  (newer cards)
        sudo mkinitcpio -P
    else
        echo "→ NVIDIA packages appear to be installed."
    fi
fi

# 3. Common useful packages: codecs, fonts, firmware, utilities
echo -e "\n3. Installing common packages (codecs, fonts, firmware, tools) ..."
sudo pacman -S --needed --noconfirm \
    ttf-ms-fonts noto-fonts-emoji \
    vulkan-icd-loader libva-vdpau-driver libva-utils \
    ffmpeg ffmpegthumbnailer gst-plugin-pipewire gst-plugins-{good,bad,ugly} \
    linux-firmware intel-ucode amd-ucode \
    networkmanager network-manager-applet \
    ufw gufw \
    bash-completion fish zsh \
    git base-devel paru   # paru AUR helper is usually already there, but ensure

# Optional: extra Intel/AMD GPU media packages (chwd often installs these already)
sudo pacman -S --needed --noconfirm intel-media-driver intel-media-sdk onevpl-intel-gpu || true

# 4. Firewall setup (ufw) — simple + enable
echo -e "\n4. Setting up ufw firewall (allow ssh if needed) ..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
# Uncomment if you use SSH:
# sudo ufw allow ssh
sudo ufw --force enable
sudo systemctl enable --now ufw

# 5. Gaming packages (very common on CachyOS)
read -p "Install gaming meta-packages (cachyos-gaming-meta + applications)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n5. Installing gaming packages ..."
    sudo pacman -S --needed --noconfirm cachyos-gaming-meta cachyos-gaming-applications
    # Optional extras many gamers want
    sudo pacman -S --needed --noconfirm mangohud goverlay gamemode vkbasalt
fi

# 6. Optional QoL / performance tweaks
echo -e "\n6. Some optional tweaks ..."
# Enable AppArmor if not already (security)
sudo systemctl enable --now apparmor || true

# Snapper + pacman hook for snapshots is usually already set up on CachyOS
# But confirm btrfs snapper if using btrfs
if df -T / | grep -q btrfs; then
    sudo pacman -S --needed --noconfirm snapper snap-pac
    echo "→ btrfs detected — snapper should already be configured via CachyOS defaults"
fi

# 7. Final update + mkinitcpio rebuild (just in case)
echo -e "\n7. Final system update & initramfs rebuild ..."
sudo pacman -Syu --noconfirm
sudo mkinitcpio -P

echo -e "\n============================================================="
echo "Done! Reboot recommended → sudo reboot"
echo "After reboot:"
echo "  • Check GPU: nvidia-smi (NVIDIA) | glxinfo | grep renderer"
echo "  • Use CachyOS Hello / Package Installer for more GUI-based apps"
echo "  • Wiki: https://wiki.cachyos.org/configuration/post_install_setup"
echo "  • Forum: https://discuss.cachyos.org"
echo "Enjoy CachyOS! 🚀"
