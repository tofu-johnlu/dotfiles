#!/usr/bin/env bash

# Linux package installation script
# This script installs common development tools and utilities for Linux

set -e

echo "Installing common development tools for Linux..."

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    INSTALL_CMD="sudo apt-get install -y"
    UPDATE_CMD="sudo apt-get update"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
    UPDATE_CMD="sudo dnf check-update || true"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y"
    UPDATE_CMD="sudo yum check-update || true"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
    UPDATE_CMD="sudo pacman -Sy"
else
    echo "No supported package manager found. Please install packages manually."
    exit 1
fi

echo "Detected package manager: $PKG_MANAGER"
echo "Updating package lists..."
$UPDATE_CMD

# Core utilities
echo "Installing core utilities..."
$INSTALL_CMD \
    curl \
    wget \
    git \
    zsh \
    tmux \
    neovim \
    ripgrep \
    tree \
    htop \
    unzip \
    build-essential 2>/dev/null || $INSTALL_CMD curl wget git zsh tmux neovim ripgrep tree htop unzip

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install powerlevel9k theme if not already installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ]; then
    echo "Installing powerlevel9k theme..."
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

# Install Hack Nerd Font
echo "Installing Hack Nerd Font..."

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Download the font zip file
wget -O "$TEMP_DIR/font.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip"

# Unzip the font file
unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"

# Move the font files to the system fonts directory
sudo mv "$TEMP_DIR"/*.ttf /usr/local/share/fonts/

# Update the font cache
fc-cache -f -v

# Clean up
rm -rf "$TEMP_DIR"

echo "Fonts installed successfully!"


echo "Installing Factory AI CLI..."

# Install Factory AI CLI
curl -fsSL https://app.factory.ai/cli | sh

echo "Package installation complete!"
echo "Note: You may need to install additional packages depending on your needs."
