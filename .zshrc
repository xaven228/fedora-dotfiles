# ===== БАЗА =====
export EDITOR="nano"
export VISUAL="nano"
export BROWSER="firefox"
export TERMINAL="ptyxis"

# ===== PATH =====
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/share/pnpm:$PATH"

# ===== ИСТОРИЯ =====
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# ===== НАВИГАЦИЯ =====
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# ===== АВТОДОПОЛНЕНИЕ =====
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ===== ПОДСКАЗКИ И PROMPT =====
autoload -Uz colors && colors
setopt PROMPT_SUBST

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %F{magenta}[%b]%f'
zstyle ':vcs_info:*' enable git

PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f${vcs_info_msg_0_} %# '
RPROMPT=''

# ===== ПОЛЕЗНЫЕ ОПЦИИ =====
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS

# ===== ALIASES: БАЗОВЫЕ =====
alias ls='eza --icons'
alias ll='eza -lah --icons'
alias la='eza -a --icons'
alias lt='eza --tree --level=2 --icons'
alias cat='bat --paging=never'
alias grep='grep --color=auto'
alias cls='clear'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ===== ALIASES: GIT =====
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gsw='git switch'
alias gst='git stash'
alias gsp='git stash pop'

# ===== ALIASES: DOCKER =====
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcr='docker compose restart'

# ===== ALIASES: СИСТЕМА =====
alias update='sudo dnf upgrade --refresh -y'
alias install='sudo dnf install -y'
alias remove='sudo dnf remove -y'
alias search='dnf search'
alias cleanup='sudo dnf autoremove -y && sudo dnf clean all'
alias ports='ss -tulpn'
alias myip='curl -4 ifconfig.me; echo'
alias pingg='ping 8.8.8.8'
alias ff='fastfetch'
alias jctl='journalctl -p 3 -xb'
alias fixdocker='sudo systemctl restart docker'

# ===== ALIASES: RDP / РАБОТА =====
alias workpc='xfreerdp3 /u:corp\\sazonov.rk /v:10.18.130.170 /dynamic-resolution /clipboard /cert:ignore /sound /microphone'

# ===== ALIASES: NODE / PNPM =====
alias ni='pnpm install'
alias nid='pnpm install --save-dev'
alias nr='pnpm run'
alias nd='pnpm dev'
alias nb='pnpm build'
alias ns='pnpm start'

# ===== ALIASES: JAVA =====
alias mci='./mvnw clean install'
alias msr='./mvnw spring-boot:run'
alias gradleclean='./gradlew clean'
alias gradlebuild='./gradlew build'

# ===== FZF =====
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# ===== ZOXIDE =====
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ===== БЕЗОПАСНЫЕ ФУНКЦИИ =====
mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.7z)      7z x "$1" ;;
      *) echo "Не знаю как распаковать: $1" ;;
    esac
  else
    echo "Файл не найден: $1"
  fi
}

# ===== ПРОКСИ / VPN HELPERS =====
proxyoff() {
  unset http_proxy https_proxy ftp_proxy all_proxy
  unset HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY
  echo "Proxy выключен"
}

# ===== ПРИВЕТСТВИЕ =====
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
