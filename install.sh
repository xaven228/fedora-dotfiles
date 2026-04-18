#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
MODE="copy"
DRY_RUN=0
CONFIGURE_GIT=1

FILES=(
  ".zshrc"
  ".gitconfig"
  ".gitignore_global"
  ".vimrc"
)

SELECTED_FILES=()

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  --copy            Copy files into $HOME (default)
  --symlink         Create symlinks into $HOME
  --file NAME       Install only one file, can be used multiple times
  --dry-run         Show what would happen without changing anything
  --no-git          Skip `git config --global core.excludesfile`
  -h, --help        Show this help message

Examples:
  ./install.sh
  ./install.sh --symlink
  ./install.sh --file .zshrc --file .gitconfig
  ./install.sh --dry-run --symlink
EOF
}

log() {
  echo "$1"
}

run_cmd() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "[dry-run] $*"
    return
  fi

  "$@"
}

require_command() {
  local cmd="$1"

  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command not found: $cmd" >&2
    exit 1
  fi
}

is_supported_file() {
  local requested="$1"
  local file

  for file in "${FILES[@]}"; do
    if [[ "$file" == "$requested" ]]; then
      return 0
    fi
  done

  return 1
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --copy)
        MODE="copy"
        ;;
      --symlink)
        MODE="symlink"
        ;;
      --file)
        shift
        if [[ $# -eq 0 ]]; then
          echo "Error: --file requires a value" >&2
          exit 1
        fi
        if ! is_supported_file "$1"; then
          echo "Error: unsupported file '$1'" >&2
          exit 1
        fi
        SELECTED_FILES+=("$1")
        ;;
      --dry-run)
        DRY_RUN=1
        ;;
      --no-git)
        CONFIGURE_GIT=0
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        echo "Error: unknown option '$1'" >&2
        echo
        usage
        exit 1
        ;;
    esac
    shift
  done
}

prepare_files() {
  if [[ "${#SELECTED_FILES[@]}" -gt 0 ]]; then
    FILES=("${SELECTED_FILES[@]}")
  fi
}

backup_file() {
  local target="$1"

  if [[ -e "$target" || -L "$target" ]]; then
    run_cmd mkdir -p "$BACKUP_DIR"
    run_cmd cp -a "$target" "$BACKUP_DIR/"
    log "Backed up $target -> $BACKUP_DIR/"
  fi
}

install_file() {
  local name="$1"
  local source="$REPO_DIR/$name"
  local target="$HOME/$name"

  if [[ ! -f "$source" ]]; then
    log "Skipping missing file: $source"
    return
  fi

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    log "Already linked: $target -> $source"
    return
  fi

  backup_file "$target"

  if [[ "$MODE" == "symlink" ]]; then
    run_cmd rm -f "$target"
    run_cmd ln -s "$source" "$target"
    log "Linked $name"
  else
    run_cmd cp "$source" "$target"
    log "Installed $name"
  fi
}

configure_git() {
  if [[ "$CONFIGURE_GIT" -eq 0 ]]; then
    log "Skipping git global excludesfile configuration"
    return
  fi

  require_command git
  run_cmd git config --global core.excludesfile "$HOME/.gitignore_global"
  log "Configured git global excludesfile"
}

print_post_install_notes() {
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
}

parse_args "$@"
prepare_files

require_command cp
require_command readlink
if [[ "$MODE" == "symlink" ]]; then
  require_command ln
  require_command rm
fi

echo "Installing dotfiles from $REPO_DIR"
echo "Mode: $MODE"
if [[ "${#FILES[@]}" -lt 4 ]]; then
  echo "Files: ${FILES[*]}"
fi

for file in "${FILES[@]}"; do
  install_file "$file"
done

configure_git
print_post_install_notes
