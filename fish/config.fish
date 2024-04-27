# Remove greeting at startup
set -g fish_greeting
# fdfind may not need to be renamed, only in ubuntu, ignore for now
alias cat="bat"
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
# rust binaries (bob, fnm, uv)
set --export PATH $HOME/.cargo/bin $PATH
set --export PATH "/home/amg/.local/share/fnm" $PATH
# Neovim via bob
set --export PATH "/home/amg/.local/share/bob/nvim-bin" $PATH


# fnm
fnm env | source

# Runs Starship prompt
starship init fish | source

# Zoxide init
zoxide init fish | source
