#!/usr/bin/env bash
# Instala este fork de caelestia enlazando (symlink) sus carpetas dentro de ~/.config.
# Si ya existe una config en ese lugar, se hace un backup antes de reemplazarla.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="$CONFIG_DIR/caelestia-dots-backup-$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Guardando backup de $dest -> $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    elif [ -L "$dest" ]; then
        rm "$dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "Enlazado $dest -> $src"
}

link "$REPO_DIR/hypr" "$CONFIG_DIR/hypr"
link "$REPO_DIR/caelestia" "$CONFIG_DIR/caelestia"
mkdir -p "$CONFIG_DIR/quickshell"
link "$REPO_DIR/quickshell/caelestia" "$CONFIG_DIR/quickshell/caelestia"

cat <<'EOF'

Listo. Recordá:

  - Necesitás paru/yay instalados: caelestia-cli y caelestia-shell (o al menos
    hyprland y quickshell) como dependencias base.
  - hypr/monitors.conf y hypr/monitors.lua (y caelestia/monitors/*) fueron
    generados por nwg-displays para MI hardware. Regeneralos con nwg-displays
    para que coincidan con tus monitores, o Hyprland puede fallar al arrancar.
  - Reiniciá Hyprland (o el shell con `caelestia shell`) para aplicar cambios.

EOF
