# Dotfiles

Cross-platform dotfiles for Linux and macOS with automatic OS detection and unified package management.

![Screenshot of my shell prompt](https://i.imgur.com/EkEtphC.png)

## Features

- **OS Detection**: Automatically detects and configures for Linux or macOS
- **Unified Package Manager**: Uses Homebrew for both Linux and macOS with automatic PATH configuration
- **Modern Shell Setup**: Prezto + Starship for a blazingly fast and beautiful shell experience
- **Safe Installation**: Backs up existing dotfiles before making changes
- **User-Friendly**: Visual feedback with spinners and status indicators during installation
- **Idempotent**: Safe to run multiple times without issues

## What's New

This repository has been significantly refactored from the original fork:

- ✨ **Unified Package Manager**: Single installer using Homebrew for both Linux and macOS
- 🚀 **Modern Shell Stack**: Replaced oh-my-zsh + powerlevel9k with Prezto + Starship
- 🎯 **Better UX**: Loading spinners, status indicators, and idempotent operations
- 📦 **Consolidated Structure**: Common installer replaces separate Linux/macOS package scripts
- 🔧 **Improved Installation**: Modular installation with clear prompts for each component
- 📝 **Enhanced Documentation**: Comprehensive troubleshooting and customization guides

See `REFACTORING_NOTES.md` for detailed technical changes.

## Directory Structure

```
dotfiles/
├── common/                 # Shared configurations across all OS
│   ├── .gitconfig
│   ├── .hushlogin
│   ├── .inputrc
│   ├── .screenrc
│   ├── .tmux.conf
│   ├── .zshrc             # Base zsh configuration
│   ├── .zprofile          # Shell profile configuration
│   └── install-packages.sh # Unified package installer (Homebrew-based)
├── linux/                  # Linux-specific configurations
│   └── brew.sh            # Additional Linux packages via Homebrew
├── macos/                  # macOS-specific configurations
│   ├── .tmux.conf.osx
│   ├── .zshrc             # macOS-specific zsh additions
│   ├── .zprofile          # macOS-specific profile additions
│   ├── Brewfile           # GUI applications for macOS
│   ├── brew.sh            # Additional macOS packages (CTF tools, etc.)
│   ├── macos.sh           # macOS system defaults
│   └── iterm/             # iTerm2 configurations
├── install.sh              # Main installation script with OS detection
├── gitalias.txt            # Git alias reference
└── README.md
```

## Installation

### Prerequisites

1. Git must be installed
2. For macOS: Command Line Tools (installed automatically by Homebrew if missing)
3. For Linux: Will be installed automatically during setup

### Quick Install

```bash
cd ~
git clone https://github.com/tofu-johnlu/dotfiles.git
cd dotfiles
./install.sh
```

The installation script will:
1. Detect your operating system (Linux or macOS)
2. Pull latest changes from git
3. Create backups of existing dotfiles (with timestamp)
4. Create symlinks for common configuration files
5. Offer to install common packages (Homebrew, CLI tools, Prezto, Starship)
6. Compose `.zshrc` by copying base config and appending OS-specific customizations
7. Offer OS-specific installations:
   - **Linux**: Additional packages via Homebrew
   - **macOS**: CTF/dev tools, GUI applications, and system defaults

### Manual Installation Steps

If you prefer to set up manually:

#### Common Setup (Both Linux and macOS):

```bash
cd ~/dotfiles

# Install common dotfiles
ln -sf ~/dotfiles/common/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/common/.hushlogin ~/.hushlogin
ln -sf ~/dotfiles/common/.inputrc ~/.inputrc
ln -sf ~/dotfiles/common/.screenrc ~/.screenrc
ln -sf ~/dotfiles/common/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/common/.zprofile ~/.zprofile

# Install common packages (Homebrew, CLI tools, Prezto, Starship)
bash ~/dotfiles/common/install-packages.sh

# Create .zshrc with OS-specific additions
cp ~/dotfiles/common/.zshrc ~/.zshrc
```

#### For Linux:

```bash
# Append Linux-specific zsh configuration (if exists)
cat ~/dotfiles/linux/.zshrc >> ~/.zshrc 2>/dev/null || true

# Optional: Install additional Linux packages
bash ~/dotfiles/linux/brew.sh
```

#### For macOS:

```bash
# Link macOS-specific files
ln -sf ~/dotfiles/macos/.zprofile ~/.zprofile.local
ln -sf ~/dotfiles/macos/.tmux.conf.osx ~/.tmux.conf.osx

# Append macOS-specific zsh configuration
cat ~/dotfiles/macos/.zshrc >> ~/.zshrc

# Optional: Install additional CLI tools (CTF, development, etc.)
bash ~/dotfiles/macos/brew.sh

# Optional: Install GUI applications
brew bundle --file ~/dotfiles/macos/Brewfile

# Optional: Set macOS system defaults
sudo bash ~/dotfiles/macos/macos.sh
```

## Package Installation

### Common Packages (Both Linux and macOS)

The unified package installer (`common/install-packages.sh`) uses Homebrew as the package manager for both platforms and installs:

**Homebrew Installation:**
- Automatically installs Homebrew if not present
- Configures PATH for your OS and architecture
- Installs build dependencies on Linux

**Core CLI Tools:**
- curl, wget, git, git-lfs
- zsh, tmux, neovim
- ripgrep, tree, htop
- mise (runtime version manager)

**Shell Setup:**
- **Prezto**: Lightweight ZSH configuration framework (replaces oh-my-zsh)
- **Starship**: Modern, blazingly fast cross-shell prompt (replaces powerlevel9k)

Run separately:
```bash
bash ~/dotfiles/common/install-packages.sh
```

### Linux-Specific Packages

Additional Linux packages can be installed via Homebrew:

```bash
bash ~/dotfiles/linux/brew.sh
```

### macOS-Specific Packages

**Additional CLI Tools** (CTF tools, development utilities):
```bash
bash ~/dotfiles/macos/brew.sh
```

Includes security tools like: aircrack-ng, nmap, sqlmap, john, hydra, and more.

**GUI Applications** (via Brewfile):
```bash
brew bundle --file ~/dotfiles/macos/Brewfile
```

See `macos/Brewfile` for the complete list of GUI applications.

## Configuration Details

### Common Configurations

These configurations are shared across all operating systems:

- **Git**: Aliases, color schemes, and global settings (see `gitalias.txt` for reference)
- **Tmux**: Terminal multiplexer with custom keybindings (C-a prefix)
- **Zsh**: Base shell configuration with Prezto framework
- **Zprofile**: Shell profile for environment setup
- **Input**: Readline configuration for better CLI input handling
- **Screen**: Screen configuration for terminal management
- **Hushlogin**: Suppresses system messages on login

### Linux-Specific

- **Zsh additions**: Linux-specific shell customizations (appended to base .zshrc)
- **Package manager**: Homebrew for Linux with automatic PATH configuration

### macOS-Specific

- **Zsh additions**: macOS aliases and utilities (appended to base .zshrc)
- **Zprofile local**: Additional macOS-specific profile settings
- **Tmux OSX**: macOS-specific tmux configurations
- **Homebrew**: Comprehensive package list via Brewfile
- **System defaults**: macOS system preferences automation (macos.sh)
- **iTerm2**: Terminal emulator profiles and keymaps

## Customization

### Git Configuration

Update your Git user information:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

For a comprehensive list of git aliases, see `gitalias.txt`.

### Shell Prompt (Starship)

The dotfiles use Starship prompt by default. To customize:

1. Create or edit `~/.config/starship.toml`
2. See [Starship configuration docs](https://starship.rs/config/)
3. Changes take effect in new terminal sessions

Example basic customization:
```toml
# ~/.config/starship.toml
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"
```

### Prezto Configuration

To customize Prezto modules and settings:

1. Edit `~/.zpreztorc` (created automatically by Prezto)
2. Enable/disable modules in the `zmodules` section
3. Reload: `source ~/.zshrc`

### Adding Your Own Configurations

1. Fork this repository
2. Add your configurations to the appropriate directory (common/linux/macos)
3. Update `install.sh` if you add new files to symlink
4. Test the installation script
5. Commit and push your changes

## Updating

To update your dotfiles to the latest version:

```bash
cd ~/dotfiles
git pull origin main
./install.sh
```

**Note**: 
- The installation script will backup existing files before overwriting
- `.zshrc` is copied (not symlinked), so you'll need to re-run `install.sh` or manually merge changes
- Symlinked files (`.gitconfig`, `.tmux.conf`, etc.) update automatically when you pull changes

## Uninstallation

To remove dotfiles and restore backups:

```bash
cd ~

# Remove symlinks
rm .gitconfig .hushlogin .inputrc .screenrc .tmux.conf .zprofile

# Remove copied files
rm .zshrc

# macOS-specific
rm .zprofile.local .tmux.conf.osx 2>/dev/null || true

# Remove Prezto (optional)
rm -rf ~/.zprezto

# Restore from backups (if desired)
# Look for files with .backup.YYYYMMDD_HHMMSS extensions
# Example: mv ~/.zshrc.backup.20231015_143022 ~/.zshrc
```

**Note**: This won't uninstall Homebrew or the packages installed via Homebrew. To remove Homebrew entirely, see the [official uninstall guide](https://docs.brew.sh/FAQ#how-do-i-uninstall-homebrew).

## Shell Configuration

### Zsh Framework

Using **Prezto** (instead of oh-my-zsh) for better performance:
- Lightweight and fast
- Modular architecture
- Sensible defaults
- Configure via `~/.zpreztorc`

### Prompt

Using **Starship** (instead of powerlevel9k):
- Written in Rust, extremely fast
- Cross-shell compatible
- Easy to configure via TOML
- Rich information display (git status, runtime versions, etc.)

### Aliases

Common aliases included in `.zshrc`:

- Navigation: `..`, `...`, `....`, `.....`
- Git: Various git aliases (see `gitalias.txt` and `.gitconfig`)
- Tmux: `ta` (attach), `tks` (kill-server), `tls` (list sessions)
- Editor: Check your `.zshrc` for configured editor shortcuts

See the full list in `common/.zshrc` and OS-specific `.zshrc` files.

## Troubleshooting

### Symlinks Not Working

If symlinks aren't being created:
1. Check file permissions: `ls -la ~/dotfiles`
2. Ensure the install script is executable: `chmod +x install.sh`
3. Run with bash explicitly: `bash install.sh`

### Homebrew Not Found After Installation

If `brew` command is not found after installation:

**For Linux:**
```bash
# Add to your current shell session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Or if installed locally:
eval "$($HOME/.linuxbrew/bin/brew shellenv)"
```

**For macOS:**
```bash
# Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"
# Intel
eval "$(/usr/local/bin/brew shellenv)"
```

Then restart your terminal or run: `source ~/.zshrc`

### Prezto or Starship Not Loading

If the shell prompt isn't working correctly:

1. Check if Prezto is installed: `ls -la ~/.zprezto`
2. Check if Starship is installed: `command -v starship`
3. Verify your `.zshrc` has the initialization code:
   ```bash
   # For Prezto
   grep "zprezto/init.zsh" ~/.zshrc
   # For Starship
   grep "starship init" ~/.zshrc
   ```
4. Re-run the common package installer: `bash ~/dotfiles/common/install-packages.sh`

### Package Installation Fails

**General:**
- Check internet connectivity
- Ensure you have sufficient disk space

**For Linux:**
- Build dependencies may be needed (automatically installed by the script)
- You may need sudo privileges for system package managers
- Check: `sudo apt-get update` (Debian/Ubuntu) or equivalent for your distro

**For macOS:**
- Xcode Command Line Tools are installed automatically by Homebrew
- If Homebrew installation fails, try the manual install:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## Warning

**Important**: If you want to use these dotfiles, you should:
1. Fork this repository
2. Review the code and configurations
3. Remove things you don't want or need
4. Customize to your preferences

Don't blindly use these settings unless you understand what they do!

## Credits

Originally forked and customized from various dotfiles repositories. Special thanks to the open-source community for inspiration and tools.

## License

MIT License - See LICENSE-MIT.txt for details.