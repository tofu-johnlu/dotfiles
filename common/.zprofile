# Load OS-specific configuration
[ -f ~/.zprofile.local ] && source ~/.zprofile.local

# Load API keys from local file (not tracked in git)
[ -f ~/.api_keys ] && source ~/.api_keys
