#!/bin/bash 
set -euo pipefail

# Custom packages 
REPO_PKGS=(ghostty flatpak fish visual-studio-code-bin)
AUR_PKGS=(brave-origin-bin voxtype-bin)

# Install Arch's official repo packages
echo "==> Installing repo packages: ${REPO_PKGS[*]}"
omarchy pkg add "${REPO_PKGS[@]}"

# Install AUR packages
echo "==> Installing AUR packages: ${AUR_PKGS[*]}"
omarchy pkg aur add "${AUR_PKGS[@]}"

# Add Flathub remote
if ! flatpak remotes | grep -q flathub; then
  echo "==> Adding Flathub remote"
  sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# Switching to FISH
if [[ "$SHELL" != "/usr/bin/fish" ]]; then
  echo "==> Switching default shell to fish"
  sudo chsh -s /usr/bin/fish "$USER"
fi

echo "==> Done. All personal packages installed."
echo "Log out and back in (or start a new session) for fish to take effect."
