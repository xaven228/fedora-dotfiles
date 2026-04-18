# Fedora Dotfiles

Minimal Fedora workstation setup for development, administration and an actually fast terminal.

- ZSH without `oh-my-zsh`
- practical Git aliases and sane defaults
- Vim config with search, git and IDE-like features
- Docker, Node.js and Java-friendly shell helpers

## Overview

This repository contains the dotfiles I use on Fedora for daily work. The goal is simple:

- keep everything plain-text and easy to understand
- avoid heavy frameworks
- make the terminal productive out of the box
- keep installation safe with automatic backups

## Included Files

- `.zshrc` - aliases, completion, prompt, `fzf`, `zoxide`, Docker/system helpers
- `.gitconfig` - git settings, aliases and workflow defaults
- `.gitignore_global` - global ignore rules for OS/editor junk
- `.vimrc` - Vim setup with plugins for navigation, git and Coc-based IDE features
- `install.sh` - installs configs into `$HOME` and backs up existing files first

## Quick Start

```bash
git clone git@github.com:xaven228/fedora-dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

For a symlink-based setup:

```bash
./install.sh --symlink
```

For a preview without changing anything:

```bash
./install.sh --dry-run
```

## Manual Install

```bash
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .vimrc ~/.vimrc

git config --global core.excludesfile ~/.gitignore_global
```

## Installer Options

The installer supports both copy and symlink workflows:

```bash
./install.sh --copy
./install.sh --symlink
./install.sh --file .zshrc --file .gitconfig
./install.sh --dry-run --symlink
./install.sh --no-git
```

## Recommended Packages

Target system: Fedora Workstation with GNOME.

```bash
sudo dnf install -y \
zsh git curl wget vim-enhanced \
eza bat fzf zoxide fastfetch \
htop btop \
ripgrep fd-find \
wl-clipboard xclip \
pavucontrol \
gnome-tweaks gnome-extensions-app \
file-roller unzip unrar p7zip p7zip-plugins \
openssh-clients rsync \
nmap bind-utils net-tools tcpdump \
java-21-openjdk java-21-openjdk-devel \
nodejs npm \
remmina freerdp
```

## Docker Setup

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Log out and back in after adding your user to the `docker` group.

## ZSH Setup

```bash
chsh -s "$(which zsh)"
```

Log out and back in after changing the default shell.

## Features

### Terminal

- `eza`-based `ls`, `ll`, `la`, `lt`
- interactive completion and history improvements
- `fzf` integration when installed
- `zoxide` navigation with `z`
- utility functions like `mkcd`, `extract`, `proxyoff`

### Git

- aliases like `git st`, `git aa`, `git cm`, `git lg`
- `push.autoSetupRemote = true`
- `rebase.autoStash = true`
- `merge.conflictstyle = zdiff3`

### Docker

- shortcuts like `dps`, `dpsa`, `dcud`, `dcd`, `dlog`

### Vim

- `NERDTree`, `fzf.vim`, `vim-fugitive`
- `vim-airline`
- `coc.nvim` for completion/navigation

## Examples

```bash
# git
git st
git aa
git cm "init"

# docker
dps
dcud
dcd

# navigation
z my-project
```

## Structure

```text
.
├── .gitconfig
├── .gitignore
├── .gitignore_global
├── .vimrc
├── .zshrc
├── install.sh
├── LICENSE
└── README.md
```

## Notes

- no `oh-my-zsh`
- minimal dependencies
- transparent plain-text configs
- safe installer with backups

## TODO

- [ ] extend bootstrap package setup
- [ ] add Neovim alternative
- [ ] split work/private aliases
- [ ] add backup/restore helpers

## License

MIT

## Author

Ruslan Sazonov
