# Crear un symlink simple
Usando el directorio del repo como ejemplo

```bash
stow --target=<target-dir> <source-dir>
```

Es decir que si quisieramos enlazar el directorio de **nvim** al directorio objetivo **/home/<usuario>/.config/nvim/** tendremos que usar el comando

```bash
stow --target=/home/<usuario>/.config/nvim nvim
```

Lectura interesante para el uso de GNU Stow:
- https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html

## Enlazar todos los directorios, con comandos
```bash
stow --target=/home/$USER/.config/nvim nvim
stow --target=/home/$USER/.config/gallery-dl gallery-dl
stow --target=/home/$USER/.local/share/konsole konsole
stow --target=/home/$USER/.config/lazygit lazygit
stow --target=/home/$USER/.config/rclone rclone
stow --target=/home/$USER/.config/fish fish
stow --target=/home/$USER git
```
# Crear junctions en Windows

```powershell
New-Item -ItemType Junction -Path $HOME/AppData/Local -Name <name-of-the-shortcut> -Target $<dotfiles-repo-root>/nvim
```

Y después de esto, usamos NVIM_APPNAME con este atajo, nombrado como hayamos querido.

```powershell
$env:NVIM_APPNAME=<name-of-the-shortcut>; & nvim
```

Para linkar la config de Wezterm por ejemplo:

```powershell
New-Item -ItemType Junction -Path $env:HOMEPATH/.config -Name wezterm -Target $env:HOMEPATH/dotfiles/wezterm
```

Aquí el -Name corresponde al shortcut, ubicado en -Path que redireccionará a -Target cuando se acceda a él
