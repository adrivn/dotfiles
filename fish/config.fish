# Remove greeting at startup
set -g fish_greeting
# Runs Starship prompt
if status is-interactive
# Commands to run in interactive sessions can go here
starship init fish | source
atuin init fish | source
zoxide init fish | source
# bun
fish_add_path "$HOME/.bun/bin"
# custom binaries
fish_add_path "$HOME/.bin"
# uv
fish_add_path "$HOME/.cargo/env"
end
