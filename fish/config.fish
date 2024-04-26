# Remove greeting at startup
set -g fish_greeting
# Renames fdfind to fd, as it should
alias fd="fdfind"
alias cat="batcat"
alias lsd="eza --long --header --git --icons"
alias anvim="NVIM_APPNAME=anvim nvim"
alias nvchad="NVIM_APPNAME=nvchad nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# fnm
set PATH "/root/.fnm" $PATH
fnm env | source

# Runs Starship prompt
starship init fish | source

# Zoxide init
zoxide init fish | source
