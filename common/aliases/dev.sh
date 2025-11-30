#!/usr/bin/env bash
# Development tools and workflow aliases

# tmux shortcuts
alias ide="tmux splitw -v -l 10 && tmux splitw -h && tmux selectp -t 1 && vim"
alias tks="tmux kill-server"
alias ta="tmux a"
alias tls="tmux ls"
alias texit="tmux kill-session"
alias td="tmux detach-client"
alias tw="tmux new-window"
alias tnw="tmux next-window"
alias tpw="tmux previous-window"
alias tp="tmux splitw"
alias tpv="tmux splitw -v"
alias tph="tmux splitw -h"

# docker compose shortcuts
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcl="docker compose logs"
alias dcp="docker compose ps"
alias dcr="docker compose restart"
alias dcs="docker compose start"
alias dck="docker compose stop"

# Add other development-related aliases here
# Examples:
# alias python="python3"
# alias pip="pip3"
# alias dc="docker-compose"
# alias k="kubectl"

