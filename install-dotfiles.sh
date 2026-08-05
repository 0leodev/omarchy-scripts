#!/bin/bash 

HOME_DIR=$HOME

REPO_URL="https://github.com/0leodev/dotfiles"
REPO_NAME="dotfiles"

THEME_DIR="$REPO_NAME/omarchy/.config/omarchy/themes"
THEME_REPO_URL="https://github.com/0leodev/omarchy-0xleovision-theme.git"
THEME_REPO_NAME="omarchy-0xleovision-theme"

echo "==> Installing stow"
sudo pacman -S --needed --noconfirm stow

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "removing old configs"
  rm -rf ~/.config/fastfetch ~/.config/fish ~/.config/hypr ~/.config/nvim ~/.config/omarchy ~/.config/opencode ~/.config/uwsm ~/.config/waybar

cd "$REPO_NAME"
  stow fastfetch 
  stow fish
  stow hypr
  stow nvim
  stow omarchy
  stow opencode
  stow uwsm
  stow waybar 
else
  echo "Failed to clone the repository."
  exit 1
fi 

echo "==> Cloning theme into omarchy themes folder"
cd "$HOME_DIR"
if [ -d "$THEME_DIR/$THEME_REPO_NAME" ]; then
  echo "Theme already exists. Skipping clone"
else
  git clone "$THEME_REPO_URL" "$THEME_DIR/$THEME_REPO_NAME"
fi
