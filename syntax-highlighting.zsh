#!/bin/zsh

[[ -d "$HOME/.config/zsh/syntax-highlighting" ]] \
  || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.config/zsh/syntax-highlighting"  \
  || echo 'failed to install syntax-highlighting for zsh'

source "$HOME/.config/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh" 2> /dev/null
