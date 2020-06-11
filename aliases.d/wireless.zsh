#!/bin/zsh

__IFACE="${$(ip a | grep -o -P '\d+:\s+(w[a-z0-9]+)')[(w)2]}"

function __command_exists {
  hash "$1" 2>/dev/null
}

if [[ -n "$__IFACE" ]]; then
  __command_exists rfkill && alias rfkill='sudo rfkill'
  __command_exists aircheck && alias aircheck='sudo aircheck'
  __command_exists wifite && alias wifite='sudo wifite'
  __command_exists wifijammer && alias wifijammer='sudo wifijammer'
  __command_exists airodump-ng && alias airod="sudo airodump-ng -i $IFACE --wps --manufacturer"
  __command_exists reaver &&  alias rvr="sudo reaver -i $IFACE -K 1 -vv -b"
  __command_exists macchanger && alias wmac="sudo macchanger -ab $IFACE"
fi
