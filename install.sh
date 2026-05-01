#!/usr/bin/env bash
# install.sh — crea symlinks de dotfiles al home del usuario

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

echo "Dotfiles dir: $DOTFILES_DIR"
echo "Backup dir:   $BACKUP_DIR"
echo ""

# Función para crear symlink con backup del original
link() {
  local src="$DOTFILES_DIR/$1"
  local dst="$HOME/$1"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$(dirname "$BACKUP_DIR/$1")"
    mv "$dst" "$BACKUP_DIR/$1"
    echo "  [backup] $dst"
  elif [ -L "$dst" ]; then
    rm "$dst"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "  [link]   $dst -> $src"
}

echo "=== Shell files ==="
link ".bashrc"
link ".zshrc"
link ".bash_profile"
link ".profile"
link ".bash_aliases"

echo ""
echo "=== .config ==="
link ".config/hypr"
link ".config/waybar"
link ".config/wofi"
link ".config/kitty"
link ".config/fish"
link ".config/btop"
link ".config/cava"
link ".config/nvim"
link ".config/autostart"

echo ""
echo "Instalación completa."
[ -d "$BACKUP_DIR" ] && echo "Backups guardados en: $BACKUP_DIR" || echo "No se necesitaron backups."
