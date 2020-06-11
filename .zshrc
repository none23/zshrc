#!/bin/zsh

[[ $- != *i* ]] && return
[[ -a "$XDG_CONFIG_HOME/zsh/rc.zsh" ]] \
  && source "$XDG_CONFIG_HOME/zsh/rc.zsh"
