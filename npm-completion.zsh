#!/bin/zsh

__npm_completion () {
  local cword line point words si
  read -Ac words
  read -cn cword
  let cword-=1
  read -l line
  read -ln point
  si="$IFS"
  IFS=$'\n' reply=($(COMP_CWORD="$cword" COMP_LINE="$line" COMP_POINT="$point" npm completion -- "${words[@]}" 2>/dev/null)) || return $?
  IFS="$si"
}

compctl -K __npm_completion npm
