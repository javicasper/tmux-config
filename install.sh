#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════
#  install.sh — instala la config de tmux de Javier en esta máquina
#  Crea un symlink ~/.tmux.conf -> este repo, de modo que editar la
#  config = editar el repo (sincronizas con git pull / git push).
# ════════════════════════════════════════════════════════════════════
set -euo pipefail

# Directorio donde vive este script (raíz del repo)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/.tmux.conf"
DEST="$HOME/.tmux.conf"
TPM_DIR="$HOME/.tmux/plugins/tpm"

echo "▶ Instalando config de tmux desde: $REPO_DIR"

# 1) ¿tmux instalado?
if ! command -v tmux >/dev/null 2>&1; then
  echo "⚠  tmux no está instalado."
  echo "   Termux:  pkg install tmux git"
  echo "   Debian:  sudo apt install tmux git"
  echo "   macOS :  brew install tmux git"
  exit 1
fi

# 2) Symlink de ~/.tmux.conf -> repo (con backup si ya existe un archivo real)
if [ -L "$DEST" ]; then
  echo "↻ Ya existe un symlink en $DEST, lo reemplazo."
  rm "$DEST"
elif [ -e "$DEST" ]; then
  BACKUP="$DEST.backup.$(date +%Y%m%d%H%M%S)"
  echo "💾 Hago backup de tu config actual -> $BACKUP"
  mv "$DEST" "$BACKUP"
fi
ln -s "$SRC" "$DEST"
echo "🔗 $DEST -> $SRC"

# 2.5) Avisar de dependencias opcionales de algunos plugins
command -v fzf   >/dev/null 2>&1 || echo "⚠  'fzf' no encontrado (lo usan sessionx y fzf-url).  Termux: pkg install fzf"
command -v cargo >/dev/null 2>&1 || echo "⚠  'cargo/rust' no encontrado (lo necesita tmux-thumbs para compilar).  Termux: pkg install rust"

# 3) Instalar TPM (gestor de plugins) si no está
if [ ! -d "$TPM_DIR" ]; then
  echo "⬇  Instalando TPM en $TPM_DIR"
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✓ TPM ya estaba instalado."
fi

# 4) Instalar/actualizar los plugins definidos en .tmux.conf (sin sesión interactiva)
echo "🔌 Instalando plugins con TPM…"
"$TPM_DIR/bin/install_plugins" || true

echo
echo "✅ Listo. Abre tmux y recarga con:  prefijo (C-a) + r"
echo "   O desde dentro de tmux:  tmux source-file ~/.tmux.conf"
