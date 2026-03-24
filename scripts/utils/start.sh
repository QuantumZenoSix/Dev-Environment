#!/usr/bin/env bash

# Setup
mkdir -p ~/.config &> /dev/null
cd ~/.config/

if [ -f home-manager/home.nix ]; then
    echo "'~/config/home-manager' not empty, please empty and try again"
    exit
fi

git clone https://github.com/QuantumZenoSix/Dev-Environment.git
mv Dev-Environment home-manager
cd home-manager

pwd
echo "What would you like to install/configure?"
echo ""

# The array of choices (index 1-based in select)
options=(
  "Everything (Packages, config files, customized shell/prompt, and Neovim configuration)"
  "Packages"
  "Config files"
  "Neovim configuration"
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
      . ./scripts/utils/controller.sh full
      break
      ;;
    2)
      echo ""
      echo "→ Selected: Packages only"
      . ./scripts/utils/controller.sh pkgsonly
      break
      ;;
    3)
      echo ""
      echo "→ Selected: Config files only"
      . ./scripts/utils/controller.sh configonly
      break
      ;;
    4)
      echo ""
      echo "→ Selected: Neovim configuration only"
      . ./scripts/utils/controller.sh nvimonly
      break
      ;;
    5)
        echo ""
        echo "→ Selected: [desktop] Everything+ (Pop! OS)"
        . ./scripts/utils/controller.sh full desktop pop
        break
        ;;
    6)
      echo ""
      echo "→ Selected: [desktop] Everything+ (Cachy OS)"
      . ./scripts/utils/controller.sh full desktop cachy
      break
      ;;
    7)
      echo "Goodbye."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a number between 1 and ${#options[@]}."
      ;;
  esac
done

echo ""







