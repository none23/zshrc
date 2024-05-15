#!/bin/zsh

# bun completions
[ -s "/home/n/.bun/_bun" ] && source "/home/n/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

