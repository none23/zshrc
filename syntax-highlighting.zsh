#!/bin/zsh

__directory_exists () { [[ -d "$1" ]] }

__PLUGIN_PATH="$XDG_CONFIG_HOME/zsh/syntax-highlighting"
__directory_exists "$__PLUGIN_PATH" \
  || git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  || echo 'failed to install syntax-highlighting for zsh'

source "$__PLUGIN_PATH/zsh-syntax-highlighting.zsh" 2> /dev/null
