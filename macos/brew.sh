#!/usr/bin/env bash

cd $(dirname $BASH_SOURCE);

# Install command-line tools using Homebrew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)


# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
# brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
#brew install exiv2
brew install git
brew install git-lfs
brew install gs
brew install imagemagick
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli
# Node.js version manager
brew install nodebrew
# UNIX shell (command interpreter)
brew install zsh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Install Hack Nerd Font
brew install font-hack-nerd-font

# Install GUI
brew bundle --file $PWD/Brewfile

# Remove outdated versions from the cellar.
brew cleanup
