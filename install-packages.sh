#!/bin/bash 
set -euo pipefail

# Custom packages 
REPO_PKGS=(flatpak omarchy-zsh omarchy-fish)
AUR_PKGS=(visual-studio-code-bin brave-origin-beta-bin voxtype-bin)

# Sync package databases first
echo "==> Syncing package databases"
sudo pacman -Syu

# Install Arch's official repo packages
echo "==> Installing repo packages: ${REPO_PKGS[*]}"
omarchy pkg add "${REPO_PKGS[@]}"

# Install AUR packages
echo "==> Installing AUR packages: ${AUR_PKGS[*]}"
omarchy pkg aur add "${AUR_PKGS[@]}"

# Voxtype: download model + start daemon, so the DEL keybinding works
voxtype setup --download --model base.en
systemctl --user enable --now voxtype.service

# Add Flathub remote
if ! flatpak remotes | grep -q flathub; then
  echo "==> Adding Flathub remote"
  sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# Install and set Ghostty as default terminal
echo "==> Setting up Ghostty"
omarchy-install-terminal ghostty

# Switching to ZSH
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  echo "==> Switching default shell to zsh"
  sudo chsh -s /usr/bin/zsh "$USER"
fi

echo "==> Done. All personal packages installed."
echo "Log out and back in (or start a new session) for zsh to take effect."
