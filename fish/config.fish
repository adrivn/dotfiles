# Remove greeting at startup
set -g fish_greeting
# Add path
fish_add_path -m ~/.local/bin
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
set --export PATH $HOME/.local/share/fnm $PATH
# Neovim via bob
set --export PATH $HOME/.local/share/bob/nvim-bin $PATH
# Apps path
set --export PATH $HOME/Apps $PATH


# fnm
fnm env | source

# Runs Starship prompt
starship init fish | source

# Zoxide init
zoxide init fish | source

# Functions
function nvimplusfzf
    if test (count $argv) -eq 0
        nvim (fzf)
    else
        nvim $argv[1]
    end
end

alias n="nvim (commandline | fzf)"
