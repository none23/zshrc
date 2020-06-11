#!/bin/zsh

__command_exists () { hash "$1" 2>/dev/null }

alias npmup="(npm outdated -g | grep -P '^[a-z-]+' -o) | xargs -d \\\\n npm i -g"

if __command_exists yay; then
  alias Y='pacman -Syu && yay -Syua && npmup'
  alias Yy='pacman -Syy && yay -Syy'
  alias Yc='pacman -Sc && yay -Sc'
  alias Ycc='pacman -Scc && yay -Scc && npm -g cache clean --force'
  alias yor='yay -Rsc $(yay -Qtdq)'
  alias pacman='sudo pacman'
elif __command_exists apt; then
  alias Y='sudo apt-get update && sudo apt-get dist-upgrade && npmup'
  alias apt='sudo apt'
elif __command_exists brew; then
  alias Y='brew update && brew upgrade && (brew cu || brew tap buo/cask-upgrade && brew update && brew cu) && npmup'
fi
