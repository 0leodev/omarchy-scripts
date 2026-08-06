#!/bin/bash 

HOME_DIR=$HOME

DOTFILES_REPO_URL="https://github.com/0leodev/dotfiles"
DOTFILES_REPO_NAME="dotfiles"

THEME_DIR="$HOME_DIR/.config/omarchy/themes"
THEME_REPO_URL="https://github.com/0leodev/omarchy-0xleovision-theme.git"
THEME_NAME="0xleovision"

CONFIGS=(fastfetch fish hypr nvim opencode uwsm waybar voxtype)
BRANDING_DIR="$HOME_DIR/.config/omarchy/branding"

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
if [ "$CLONE_OK" = true ] && cd "$HOME_DIR/$DOTFILES_REPO_NAME"; then
  echo "removing old configs"
  rm -rf "${CONFIGS[@]/#/$HOME/.config/}" "$BRANDING_DIR" 
  stow "${CONFIGS[@]}"

# Copy the branding folder
  echo "==> Copying branding folder"
  mkdir -p "$HOME_DIR/.config/omarchy"
  cp -r branding "$BRANDING_DIR"  
else
  echo "Failed to clone the repository."
  exit 1
fi 

# Add my personal theme
echo "==> Cloning theme into omarchy themes folder"
if [ -d "$THEME_DIR/$THEME_NAME" ]; then
  echo "Theme $THEME_NAME already exists. Skipping clone"
else
  mkdir -p "$THEME_DIR"
  if ! git clone "$THEME_REPO_URL" "$THEME_DIR/$THEME_NAME"; then
    echo "Failed to clone theme."
    exit 1
  fi
fi
