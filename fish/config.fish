# Remove greeting at startup
set -g fish_greeting
# Add path
fish_add_path -m ~/.local/bin
# mise
mise activate fish | source
# Add atuin
source $HOME/.atuin/bin/env.fish

# fdfind may not need to be renamed, only in ubuntu, ignore for now
alias cat="bat"
alias lsd="eza --long --header --git --icons"

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

# Apps path
set --export PATH $HOME/Apps $PATH

# Runs Starship prompt
starship init fish | source
# Zoxide init
zoxide init fish | source
