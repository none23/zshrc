#!/bin/zsh

function __source_if_exists () {
  [[ -a "$1" ]] && source "$1"
}

function __ensure_directory_exists () {
  [[ -d "$1" ]] || mkdir -p "$1"
}


# vim-mode
bindkey -v
set -o vi

# history
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=256000
export SAVEHIST=2048000
setopt appendhistory


# path
__ensure_directory_exists "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$HOME/.local/node_modules/bin:/usr/bin:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:$PATH"


# ssh-agent
eval $(keychain --eval --quiet id_rsa)


# automatic startx on tty1
[[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && exec startx


source "$ZDOTDIR/xdg-directory-settings.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/syntax-highlighting.zsh"
source "$ZDOTDIR/powerline.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/npm-completion.zsh"

__source_if_exists "$ZDOTDIR/local-aliases.zsh"
