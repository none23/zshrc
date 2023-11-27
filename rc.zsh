#!/bin/zsh

# vim-mode
bindkey -v
set -o vi

# history
export HISTFILE="$HOME/.histfile"
export HISTSIZE=256000
export SAVEHIST=2048000
setopt appendhistory


# path
export ZDOTDIR="$HOME/.config/zsh"
[[ -d "$HOME/.local/bin" ]] || mkdir -p "$HOME/.local/bin" ;
export PATH="$HOME/.local/bin:$HOME/.local/share/npm/bin:/usr/bin:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:$PATH"


# ssh-agent
eval $(keychain --eval --quiet id_rsa)


source "$HOME/.config/zsh/xdg-directory-settings.zsh"
source "$HOME/.config/zsh/syntax-highlighting.zsh"
source "$HOME/.config/zsh/completion.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/npm-completion.zsh"
source "$HOME/.config/zsh/fzf.zsh"
source "$HOME/.config/zsh/powerline.zsh"
[[ -a "$HOME/.config/zsh/local-aliases.zsh" ]] && source "$HOME/.config/zsh/local-aliases.zsh"
