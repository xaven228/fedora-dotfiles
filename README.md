# Fedora Dotfiles

Minimal Fedora workstation setup for daily use:
- development (Java / Node.js / web)
- system administration
- fast terminal workflow without heavyweight frameworks

## What's Inside

- `.zshrc` - shell config with aliases, completion, `fzf`, `zoxide`, Docker and system helpers
- `.gitconfig` - git defaults and aliases for a clean everyday workflow
- `.gitignore_global` - global ignore rules for OS/editor noise
- `.vimrc` - Vim setup with file search, git integration and Coc-based IDE features
- `install.sh` - installer that backs up existing files and applies this repo to your home directory

## Quick Start

```bash
git clone git@github.com:xaven228/fedora-dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Manual Install

```bash
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp .vimrc ~/.vimrc

git config --global core.excludesfile ~/.gitignore_global
```

## Recommended Packages

Fedora Workstation / GNOME is the target environment.

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

## Docker

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Log out and back in after adding your user to the `docker` group.

## ZSH

```bash
chsh -s "$(which zsh)"
```

Log out and back in after changing the default shell.

## Highlights

### Terminal

- `eza`-based listing aliases
- `fzf` integration when installed
- smart directory jumping with `zoxide`
- helper functions like `mkcd`, `extract`, `proxyoff`

### Git

- short aliases like `git st`, `git aa`, `git cm`
- auto-upstream on push
- sensible defaults for diff, merge conflicts and rebase autostash

### Docker

- quick helpers like `dps`, `dcud`, `dcd`, `dlog`

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

## Author

Ruslan Sazonov
