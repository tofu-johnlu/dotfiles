# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERM="screen-256color"
export DEFAULT_USER="$USER"


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ============================================
# Shell Aliases
# ============================================
# Load all shell aliases from the modular alias system
# Aliases are organized in: ~/.shellalias.sh and ~/.config/shellalias/
if [ -f "$HOME/.shellalias.sh" ]; then
    source "$HOME/.shellalias.sh"
fi

# Initialize mise (runtime version manager) if installed
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

#export PATH=$HOME/.nodebrew/current/bin:$PATH
