#!/bin/zsh

__command_exists () { hash "$1" 2>/dev/null }
__file_exists () { [[ -a "$1" ]] }

__POWERLINE_INIT=$(find /usr/lib/python* -type f -path "*/site-packages/powerline/bindings/zsh/powerline.zsh" 2>/dev/null)

__init_powerline () {
  autoload -U colors && colors
  prompt off
  powerline-daemon -q
  source "$__POWERLINE_INIT"
}

__command_exists powerline-daemon \
  && __file_exists "$__POWERLINE_INIT" \
  && __init_powerline
