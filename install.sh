#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

FILES=(
  ".zshrc"
  ".gitconfig"
  ".gitignore_global"
  ".vimrc"
)

backup_file() {
  local target="$1"

  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -a "$target" "$BACKUP_DIR/"
    echo "Backed up $target -> $BACKUP_DIR/"
  fi
}

install_file() {
  local name="$1"
  local source="$REPO_DIR/$name"
  local target="$HOME/$name"

  if [[ ! -f "$source" ]]; then
    echo "Skipping missing file: $source"
    return
  fi

  backup_file "$target"
  cp "$source" "$target"
  echo "Installed $name"
}

echo "Installing dotfiles from $REPO_DIR"

for file in "${FILES[@]}"; do
  install_file "$file"
done

git config --global core.excludesfile "$HOME/.gitignore_global"
echo "Configured git global excludesfile"

if command -v zsh >/dev/null 2>&1; then
  current_shell="${SHELL##*/}"
  if [[ "$current_shell" != "zsh" ]]; then
    echo
    echo "To switch your default shell, run:"
    echo "  chsh -s \"$(command -v zsh)\""
  fi
fi

echo
echo "Done."
if [[ -d "$BACKUP_DIR" ]]; then
  echo "Backups saved in $BACKUP_DIR"
fi
