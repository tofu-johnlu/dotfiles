#!/usr/bin/env bash

# Dotfiles installation script with OS detection
# This script sets up dotfiles for Linux or macOS

set -e

cd "$(dirname "$0")"

# Default to automatic installation (no prompts)
MANUAL_MODE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--manual)
            MANUAL_MODE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Dotfiles installation script with OS detection"
            echo ""
            echo "Options:"
            echo "  -m, --manual    Enable manual mode (prompt for confirmations)"
            echo "  -h, --help      Show this help message"
            echo ""
            echo "Default behavior: Fully automatic installation (no prompts)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run '$0 --help' for usage information"
            exit 1
            ;;
    esac
done

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

echo "=================================="
echo "Dotfiles Installation Script"
echo "=================================="
echo "Detected OS: $OS"
echo "Installation Mode: $([ "$MANUAL_MODE" = true ] && echo "Manual (with prompts)" || echo "Automatic (no prompts)")"
echo ""

if [[ "$OS" == "unknown" ]]; then
    echo "Error: Unsupported operating system: $OSTYPE"
    exit 1
fi

# Function to backup existing files
backup_file() {
    local file=$1
    if [ -e "$file" ] || [ -L "$file" ]; then
        local backup_dir="$HOME/.backup"
        mkdir -p "$backup_dir"
        local basename=$(basename "$file")
        local backup="$backup_dir/${basename}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  Backing up existing $file to $backup"
        mv "$file" "$backup"
    fi
}

# Function to create symlink with backup
safe_symlink() {
    local source=$1
    local target=$2

    backup_file "$target"
    ln -sf "$source" "$target"
    echo "  Linked: $target -> $source"
}

# Pull latest changes
echo "Pulling latest changes from git..."
git pull origin main 2>/dev/null || echo "  (Skipping git pull - not in a git repo or no remote)"
echo ""

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p ~/.ssh
mkdir -p ~/.config
echo ""

# Install common dotfiles
echo "Installing common dotfiles..."
DOTFILES_DIR="$(pwd)"
COMMON_DIR="$DOTFILES_DIR/common"

safe_symlink "$COMMON_DIR/.gitconfig" "$HOME/.gitconfig"
# safe_symlink "$COMMON_DIR/.gitignore" "$HOME/.gitignore"
safe_symlink "$COMMON_DIR/.hushlogin" "$HOME/.hushlogin"
safe_symlink "$COMMON_DIR/.inputrc" "$HOME/.inputrc"
safe_symlink "$COMMON_DIR/.screenrc" "$HOME/.screenrc"
safe_symlink "$COMMON_DIR/.tmux.conf" "$HOME/.tmux.conf"
safe_symlink "$COMMON_DIR/.zprofile" "$HOME/.zprofile"
safe_symlink "$COMMON_DIR/.ssh/config" "$HOME/.ssh/config"
# safe_symlink "$COMMON_DIR/.config/nvim" "$HOME/.config/nvim"

echo ""

# Configure git to include gitalias
echo "Configuring git aliases..."
git config --global --add include.path "$COMMON_DIR/gitalias.txt"
echo "  Added gitalias.txt to git config"

echo ""

# Install .zshrc with OS-specific customizations
# This must be done BEFORE installing packages so that package installers can append to it
echo "Installing .zshrc..."
backup_file "$HOME/.zshrc"
cp "$COMMON_DIR/.zshrc" "$HOME/.zshrc"
echo "  Copied: $COMMON_DIR/.zshrc -> $HOME/.zshrc"

echo ""

# Install common packages
# This comes AFTER .zshrc installation so packages can add their configs to it
echo ""
if [[ "$MANUAL_MODE" == true ]]; then
    echo "Would you like to install common packages? (y/n)"
    read -r install_common_packages
else
    install_common_packages="y"
fi

if [[ "$install_common_packages" =~ ^[Yy]$ ]]; then
    echo "Installing common packages..."
    bash "$COMMON_DIR/install-packages.sh"
else
    echo "Skipping common package installation."
    echo "You can run it later with: bash $COMMON_DIR/install-packages.sh"
fi

# Append OS-specific .zshrc content if it exists
if [[ "$OS" == "linux" ]]; then
    LINUX_DIR="$DOTFILES_DIR/linux"
    if [ -f "$LINUX_DIR/.zshrc" ]; then
        echo "" >> "$HOME/.zshrc"
        echo "# ============================================" >> "$HOME/.zshrc"
        echo "# Linux-specific configuration" >> "$HOME/.zshrc"
        echo "# ============================================" >> "$HOME/.zshrc"
        cat "$LINUX_DIR/.zshrc" >> "$HOME/.zshrc"
        echo "  Appended Linux-specific configuration"
    fi
elif [[ "$OS" == "macos" ]]; then
    MACOS_DIR="$DOTFILES_DIR/macos"
    if [ -f "$MACOS_DIR/.zshrc" ]; then
        echo "" >> "$HOME/.zshrc"
        echo "# ============================================" >> "$HOME/.zshrc"
        echo "# macOS-specific configuration" >> "$HOME/.zshrc"
        echo "# ============================================" >> "$HOME/.zshrc"
        cat "$MACOS_DIR/.zshrc" >> "$HOME/.zshrc"
        echo "  Appended macOS-specific configuration"
    fi
fi

echo ""

# Install OS-specific dotfiles
if [[ "$OS" == "linux" ]]; then
    echo "Installing Linux-specific dotfiles..."
    LINUX_DIR="$DOTFILES_DIR/linux"
    # Additional Linux-specific dotfiles can be added here

    echo ""
    if [[ "$MANUAL_MODE" == true ]]; then
        echo "Would you like to install additional Linux packages? (y/n)"
        read -r install_packages
    else
        install_packages="y"
    fi

    if [[ "$install_packages" =~ ^[Yy]$ ]]; then
        echo "Installing additional Linux packages..."
        bash "$LINUX_DIR/brew.sh"
    else
        echo "Skipping additional Linux packages."
        echo "You can run it later with: bash $LINUX_DIR/brew.sh"
    fi

elif [[ "$OS" == "macos" ]]; then
    echo "Installing macOS-specific dotfiles..."
    MACOS_DIR="$DOTFILES_DIR/macos"

    safe_symlink "$MACOS_DIR/.zprofile" "$HOME/.zprofile.local"
    safe_symlink "$MACOS_DIR/.tmux.conf.osx" "$HOME/.tmux.conf.osx"
    safe_symlink "$MACOS_DIR/.config/aerospace" "$HOME/.config/aerospace"

    echo ""
    if [[ "$MANUAL_MODE" == true ]]; then
        echo "Would you like to install additional macOS packages? (CTF tools, etc.) (y/n)"
        read -r install_packages
    else
        install_packages="y"
    fi

    if [[ "$install_packages" =~ ^[Yy]$ ]]; then
        echo "Installing additional macOS packages..."
        bash "$MACOS_DIR/brew.sh"
    else
        echo "Skipping additional macOS packages."
        echo "You can run it later with: bash $MACOS_DIR/brew.sh"
    fi

    echo ""
    if [[ "$MANUAL_MODE" == true ]]; then
        echo "Would you like to install macOS GUI applications? (y/n)"
        read -r install_gui
    else
        install_gui="y"
    fi

    if [[ "$install_gui" =~ ^[Yy]$ ]]; then
        echo "Installing GUI applications from Brewfile..."
        brew bundle --file "$MACOS_DIR/Brewfile"
    else
        echo "Skipping GUI application installation."
        echo "You can run it later with: brew bundle --file $MACOS_DIR/Brewfile"
    fi

    echo ""
    if [[ "$MANUAL_MODE" == true ]]; then
        echo "Would you like to set macOS defaults? (y/n)"
        read -r set_defaults
    else
        set_defaults="y"
    fi

    if [[ "$set_defaults" =~ ^[Yy]$ ]]; then
        echo "Setting macOS defaults..."
        sudo bash "$MACOS_DIR/macos.sh"
    else
        echo "Skipping macOS defaults."
        echo "You can run it later with: sudo bash $MACOS_DIR/macos.sh"
    fi
fi

echo ""
echo "=================================="
echo "Installation complete!"
echo "=================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Configure your SSH keys if needed"
echo "  3. Customize your dotfiles as needed"
echo ""