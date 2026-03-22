#!/usr/bin/env bash


cd $(dirname "$0") && cd ../ && pwd || exit
pwd
echo "What would you like to install/configure?"
echo ""

# The array of choices (index 1-based in select)
options=(
  "Everything (Packages, config files, customized shell/prompt, and Neovim configuration)"
  "Packages"
  "Config files"
  "Neovim configuration"
  "Arch-Nix hybrid (everything in #1 but system packages via Pacman + user packages via Nix/Home-Manager/Flakes)"
  "[pop-os] Everything + applications optimized for pop! os (desktop apps, graphics drivers, gaming tools, and optimizations)"
  "[cachy] Everything + applications optimized for cachy os (desktop apps, graphics drivers, gaming tools, and optimizations)"
)

options+=("Quit")

PS3="Select an option (1-${#options[@]}) → "

select choice in "${options[@]}"; do
  case $REPLY in
    1)
      echo ""
      echo "→ Selected: Everything (full setup)"
      . ./scripts/install.sh full
      break
      ;;
    2)
      echo ""
      echo "→ Selected: Packages only"
      . ./scripts/install.sh
      break
      ;;
    3)
      echo ""
      echo "→ Selected: Config files only"
      . ./scripts/config_copy.sh
      break
      ;;
    4)
      echo ""
      echo "→ Selected: Neovim configuration only"
      bash ./scripts/install.sh nvimonly
      break
      ;;
    5)
      echo ""
      echo "→ Selected: Arch-Nix hybrid setup"
      bash ./scripts/install.sh full arch nix
      break
      ;;
    6)
      echo ""
      echo "→ Selected: [desktop] Everything+ (Pop! OS)"
      bash ./scripts/install.sh full os-pop
      break
      ;;
    7)
      echo ""
      echo "→ Selected: [desktop] Everything+ (Cachy OS)"
      # Should there even be a Nix option? By default? Not at all?
      # bash ./scripts/install.sh full os-cachy nix
      # bash ./scripts/install.sh full os-cachy nix
      break
      ;;
    8)
      echo "Goodbye."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a number between 1 and ${#options[@]}."
      ;;
  esac
done

echo ""







