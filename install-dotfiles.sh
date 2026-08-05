#!/bin/bash 

HOME_DIR=$HOME

DOTFILES_REPO_URL="https://github.com/0leodev/dotfiles"
DOTFILES_REPO_NAME="dotfiles"

THEME_DIR="$HOME_DIR/$DOTFILES_REPO_NAME/omarchy/.config/omarchy/themes"
THEME_REPO_URL="https://github.com/0leodev/omarchy-0xleovision-theme.git"
THEME_NAME="0xleovision"

echo "==> Installing stow"
sudo pacman -S --needed --noconfirm stow

# Check if the repository already exists
if [ -d "$HOME_DIR/$DOTFILES_REPO_NAME" ]; then
  echo "Repository '$DOTFILES_REPO_NAME' already exists. Skipping clone"
  CLONE_OK=true
else
  if git clone "$DOTFILES_REPO_URL" "$HOME_DIR/$DOTFILES_REPO_NAME"; then
    CLONE_OK=true
  else
    CLONE_OK=false
  fi  
fi

# Check if the clone was successful
if [ "$CLONE_OK" = true ]; then
  echo "removing old configs"
  rm -rf ~/.config/fastfetch ~/.config/fish ~/.config/hypr ~/.config/nvim ~/.config/omarchy ~/.config/opencode ~/.config/uwsm ~/.config/waybar
cd "$HOME_DIR/$DOTFILES_REPO_NAME"
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

# Add my personal theme
echo "==> Cloning theme into omarchy themes folder"
cd "$HOME_DIR"
if [ -d "$THEME_DIR/$THEME_NAME" ]; then
  echo "Theme $THEME_NAME already exists. Skipping clone"
else
  if ! git clone "$THEME_REPO_URL" "$THEME_DIR/$THEME_NAME"; then
    echo "Failed to clone theme."
    exit 1
  fi
fi
