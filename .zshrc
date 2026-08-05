#!/bin/zsh

export LANG=en_US.UTF-8
export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_CACHE_HOME="$HOME/.cache"

[[ $- != *i* ]] && return

# Shell behavior
bindkey -v
set -o vi

export HISTFILE="$HOME/.histfile"
export HISTSIZE=25600000
export SAVEHIST=20480000
setopt appendhistory

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
[[ -d "$HOME/.local/bin" ]] || mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$HOME/.local/share/npm/bin:/usr/bin:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:$PATH"
[[ -d "$HOME/.local/share/cargo/bin" ]] && PATH="$HOME/.local/share/cargo/bin:$PATH"

eval $(keychain --eval --quiet id_rsa)

# Helpers
__command_exists() { hash "$1" 2>/dev/null }
__file_exists() { [[ -a "$1" ]] }
__directory_exists() { [[ -d "$1" ]] }
__ensure_directory_exists() { __directory_exists "$1" || mkdir -p "$1" }
__alias_command_if_exists() { __command_exists "$1" && alias "$1"="$2" }

# XDG directory settings
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_HOME="$XDG_CONFIG_HOME/android"
export ATOM_HOME="$XDG_DATA_HOME/atom"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

__command_exists wakatime && __ensure_directory_exists "$WAKATIME_HOME"
__command_exists psql && __ensure_directory_exists "$XDG_CONFIG_HOME/pg"
__command_exists psql && __ensure_directory_exists "$XDG_CACHE_HOME/pg"

__alias_command_if_exists mitmproxy 'mitmproxy --set confdir="$HOME/.config/mitmproxy"'
__alias_command_if_exists mitmweb 'mitmweb --set confdir="$HOME/.config/mitmproxy"'
__alias_command_if_exists tmux 'tmux -f "$HOME/.config/tmux/tmux.conf"'
__alias_command_if_exists wget 'wget --hsts-file="$HOME/.cache/wget-hsts"'

# Syntax highlighting
[[ -d "$ZDOTDIR/syntax-highlighting" ]] \
  || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZDOTDIR/syntax-highlighting" \
  || echo 'failed to install syntax-highlighting for zsh'
source "$ZDOTDIR/syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null

# Completion
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
zstyle ":completion:*:commands" rehash 1
zstyle ':acceptline' rehash true
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
  named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup bind \
  dictd gnats identd irc man messagebus postfix proxy sys www-data
zstyle nocompwarn true
autoload -Uz compinit
compinit
setopt completealiases

# General aliases
alias la='ls -AFlh --color=tty'
alias ll='ls -lFh --color=tty'
alias ls='ls --color=tty'

alias N='sudo systemctl start NetworkManager.service'
alias nmkill='sudo killall NetworkManager && echo "NetworkManager killed" || echo "Nothing to kill"'
alias wkp='xset dpms force on'
alias pretendtosleep='xset dpms force off'
alias shutdown='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'

__command_exists nvim && alias -g vi='nvim'
__command_exists nvim && alias -g vim='nvim'
__command_exists nvim && alias -g vimdiff='nvim -d'
__command_exists lazygit && alias lg='lazygit'

alias ack=ag
alias dd='sudo dd bs=4M status=progress'
alias df='df -h'
alias codex=cdx

alias cfdisk='sudo cfdisk'
alias cgdisk='sudo cgdisk'
alias du='sudo du -h'
alias fdisk='sudo fdisk'
alias fstrim='sudo fstrim'
alias gdisk='sudo gdisk'
alias hdparm='sudo hdparm'
alias lsmod='sudo lsmod'
alias mkinitcpio='sudo mkinitcpio'
alias mkfs.ext4='sudo mkfs.ext4'
alias mkfs.ext3='sudo mkfs.ext3'
alias mkfs.ext2='sudo mkfs.ext2'
alias modprobe='sudo modprobe'
alias mount='sudo mount'
alias rfkill='sudo rfkill'
alias rmmod='sudo rmmod'
alias skill='sudo kill'
alias skillall='sudo killall'
alias systemctl='sudo systemctl'
alias umount='sudo umount'
__command_exists gparted && alias gparted='sudo gparted'
__command_exists masscan && alias masscan='sudo masscan'
__command_exists minicom && alias minicom='sudo minicom'
__command_exists nmap && alias nmap='sudo nmap'

pn() { [[ ! "$*" ]] && ping -c 5 -i 0.2 8.8.8.8 || ping -c 5 -i 0.2 "$*" }

clearport() {
  local port="$1"
  local pid_text
  local -a pids

  if [[ -z "$port" || "$port" != <-> ]]; then
    echo "usage: clearport <port>" >&2
    return 1
  fi

  pid_text="$(ss -tanpH "sport = :$port" 2>/dev/null | grep -Eo 'pid=[0-9]+' | cut -d= -f2 | sort -u)"

  if [[ -z "$pid_text" ]]; then
    echo "clearport: no TCP process found on port $port" >&2
    return 1
  fi

  pids=(${(f)pid_text})
  if kill "${pids[@]}"; then
    echo "clearport: killed PID(s) ${pids[*]} on tcp:$port"
  else
    echo "clearport: failed to kill PID(s) ${pids[*]} on tcp:$port" >&2
    return 1
  fi
}

__command_exists lt && alias lt='lt -l localhost -s none23'
__command_exists ranger && rr() { [[ -n "$1" ]] && ranger "$*" || ranger "$(pwd)" }

# Tor
if __command_exists tor; then
  __ensure_tor_is_running() {
    if [[ -n "$(ps -ef | grep tor | grep -v grep)" ]]; then
      echo "tor already running"
    else
      sudo systemctl start tor.service
      echo "tor started"
    fi
  }

  if __command_exists chromium; then
    alias chromium-tor='__ensure_tor_is_running; chromium --proxy-server="socks5://localhost:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"'
  elif __command_exists chromium-browser; then
    alias chromium-tor='__ensure_tor_is_running; chromium-browser --proxy-server="socks5://localhost:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"'
  fi
fi

# Archive extraction
extract() {
  if [[ -z "$1" ]]; then
    echo "Usage: extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
  fi

  for archive in "$@"; do
    if [[ ! -f "$archive" ]]; then
      echo "'$archive' - file does not exist"
      return 1
    fi

    case "${archive%,}" in
      *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) tar xvf "$archive" ;;
      *.lzma) unlzma ./"$archive" ;;
      *.bz2) bunzip2 ./"$archive" ;;
      *.rar) unrar x -ad ./"$archive" ;;
      *.gz) gunzip ./"$archive" ;;
      *.zip) unzip ./"$archive" ;;
      *.z) uncompress ./"$archive" ;;
      *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar) 7z x ./"$archive" ;;
      *.xz) unxz ./"$archive" ;;
      *.exe) cabextract ./"$archive" ;;
      *)
        echo "extract: '$archive' - unknown archive method"
        return 1
        ;;
    esac
  done
}

# Package management
alias npmup="(npm outdated -g | grep -P '^[a-z-]+' -o) | xargs -r -d \\\\n npm i -g"

if __command_exists yay; then
  alias Y='pacman -Syu && yay -Syua && npmup'
  alias Yy='pacman -Syy && yay -Syy'
  alias Yc='pacman -Sc && yay -Sc'
  alias Ycc='pacman -Scc && yay -Scc && npm -g cache clean --force'
  alias yor='yay -Rsc $(yay -Qtdq)'
  alias pacman='sudo pacman'
elif __command_exists apt; then
  alias Y='sudo apt-get update && sudo apt-get dist-upgrade && npmup'
  alias apt='sudo apt'
elif __command_exists brew; then
  alias Y='brew update && brew upgrade && (brew cu || brew tap buo/cask-upgrade && brew update && brew cu) && npmup'
fi

if __command_exists sfw; then
  alias pnpm='sfw pnpm'
  alias npm='sfw npm'
  alias yarn='sfw yarn'
  alias bun='sfw bun'
fi

__command_exists hub && alias git='hub'

# sshuttle
if __command_exists sshuttle; then
  sshide() {
    local __SHUTTLE_PIDFILE
    if [[ -a __SHUTTLE_PIDFILE ]]; then
      echo 'sshuttle is already running'
      return 1
    fi
    sshuttle -r "$1" 0/0 --dns --daemon --pidfile "$__SHUTTLE_PIDFILE"
  }

  sshive() {
    local __SHUTTLE_PIDFILE
    if [[ -a __SHUTTLE_PIDFILE ]]; then
      echo 'sshuttle is already running'
      return 1
    fi
    sshuttle -r "$1" 0/0 --dns --verbose --pidfile "$__SHUTTLE_PIDFILE"
  }
fi

# Touchpad
if [[ -n "$(grep -i name /proc/bus/input/devices | grep -iP 'touch(pad)?')" ]]; then
  alias toff='xinput disable Elan\ Touchpad'
  alias tonn='xinput enable Elan\ Touchpad'
  ton() {
    local lockfile="$XDG_RUNTIME_DIR/.touchpad-on.lock"
    if [[ -a "$lockfile" ]]; then
      xinput disable Elan\ Touchpad
      rm "$lockfile"
    else
      xinput enable Elan\ Touchpad
      touch "$lockfile"
    fi
  }
fi

# Wireless
__IFACE="${$(ip a | grep -o -P '\d+:\s+(w[a-z0-9]+)')[(w)2]}"
if [[ -n "$__IFACE" ]]; then
  __command_exists rfkill && alias rfkill='sudo rfkill'
  __command_exists aircheck && alias aircheck='sudo aircheck'
  __command_exists wifite && alias wifite='sudo wifite'
  __command_exists wifijammer && alias wifijammer='sudo wifijammer'
  __command_exists airodump-ng && alias airod="sudo airodump-ng -i $__IFACE --wps --manufacturer"
  __command_exists reaver && alias rvr="sudo reaver -i $__IFACE -K 1 -vv -b"
  __command_exists macchanger && alias wmac="sudo macchanger -ab $__IFACE"
fi

# npm completion
__npm_completion() {
  local cword line point words saved_ifs
  read -Ac words
  read -cn cword
  let cword-=1
  read -l line
  read -ln point
  saved_ifs="$IFS"
  IFS=$'\n' reply=($(COMP_CWORD="$cword" COMP_LINE="$line" COMP_POINT="$point" npm completion -- "${words[@]}" 2>/dev/null)) || return $?
  IFS="$saved_ifs"
}
compctl -K __npm_completion npm

# fzf
__FZF_ROOT="$HOME/.fzf"
_fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1" }
_fzf_compgen_dir() { fd --type d --hidden --follow --exclude ".git" . "$1" }
__fzf_install() {
  git clone --depth 1 https://github.com/junegunn/fzf.git "$__FZF_ROOT" \
    && "$__FZF_ROOT/install"
}
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || fd --type f --exclude coverage --exclude node_modules --exclude flow-typed) 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source "$__FZF_ROOT/shell/completion.zsh" 2>/dev/null
source "$__FZF_ROOT/shell/key-bindings.zsh"

# Powerline
__POWERLINE_INIT=$(find /usr/lib/python* -type f -path "*/site-packages/powerline/bindings/zsh/powerline.zsh" 2>/dev/null)
if __command_exists powerline-daemon && __file_exists "$__POWERLINE_INIT"; then
  autoload -U colors && colors
  prompt off
  powerline-daemon -q
  source "$__POWERLINE_INIT"
fi

# Bun
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[[ -a "$ZDOTDIR/local-aliases.zsh" ]] && source "$ZDOTDIR/local-aliases.zsh"

precmd() {
  if [[ -n "${CODEX_SESSION:-}" ]]; then
    echo -ne '\a' > /dev/tty
  fi
}

export PATH="$HOME/.opencode/bin:$PATH"
eval "$(codex completion zsh)"

# Codex installer
export PATH="$HOME/.local/bin:$PATH"

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
