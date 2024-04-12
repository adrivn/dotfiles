# Remove greeting at startup
set -g fish_greeting
if status is-interactive
# Commands to run in interactive sessions can go here
# Runs Starship prompt
starship init fish | source
atuin init fish | source
zoxide init fish | source
fnm env --use-on-cd | source
# bun
fish_add_path "$HOME/.bun/bin"
# custom binaries
fish_add_path "$HOME/.bin"
fish_add_path "$HOME/.local/share/fnm"
# uv
fish_add_path "$HOME/.cargo/env"
# more aliases
alias nvchad="NVIM_APPNAME=nvchad nvim"
end
