#!/bin/zsh

__command_exists () { hash "$1" 2>/dev/null }
__file_exists () { [[ -a "$1" ]] }

__SITE_PACKAGES="/usr/lib/python3.12/site-packages" # TODO: set this automatically
__POWERLINE_INIT="$__SITE_PACKAGES/powerline/bindings/zsh/powerline.zsh"

__init_powerline () {
  autoload -U colors && colors
  prompt off
  powerline-daemon -q
  source "$__POWERLINE_INIT"
}

__command_exists powerline-daemon \
  && __file_exists "$__POWERLINE_INIT" \
  && __init_powerline
