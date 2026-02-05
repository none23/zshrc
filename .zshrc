#!/bin/zsh

export LANG=en_US.UTF-8

export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_CACHE_HOME="$HOME/.cache"


[[ $- != *i* ]] && return
[[ -a "$XDG_CONFIG_HOME/zsh/rc.zsh" ]] \
  && source "$XDG_CONFIG_HOME/zsh/rc.zsh"


precmd() {
  if [[ -n "${CODEX_SESSION:-}" ]]; then
    echo -ne '\a' > /dev/tty
  fi
}
