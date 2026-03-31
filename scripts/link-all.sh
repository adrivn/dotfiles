stow -t ~ -S userhome
stow -t ~/.config/mise -S mise
stow -t ~/.config/nvim -S nvim
stow -t ~/.config/gallery-dl -S gallery-dl
stow -t ~/.config/ghostty -S ghostty
stow -t ~/.config/lazygit -S lazygit
stow -t ~/.config/fish -S fish
stow -t ~/.config/rclone -S rclone
mkdir -p ~/.docker/cli-plugins
ln -s $(which docker-cli-plugin-docker-compose) ~/.docker/cli-plugins/docker-compose
