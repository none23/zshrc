#!/bin/zsh

__command_exists () { hash "$1" 2>/dev/null }
__alias_command_if_exists () { __command_exists "$1" && alias "$1"="$2" }

alias la='ls -AFlh --color=tty'
alias ll='ls -lFh --color=tty'
alias ls='ls --color=tty'

# NetworkManager
alias N='sudo systemctl start NetworkManager.service'
alias nmkill='sudo killall NetworkManager && echo "NetworkManager killed" || echo "Nothing to kill"'

# dpms control
alias wkp='xset dpms force on'
alias pretendtosleep='xset dpms force off'

# shutdown/reboot
alias shutdown='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'

# replace vim with neovim
__command_exists nvim && alias -g vi='nvim'
__command_exists nvim && alias -g vim='nvim'
__command_exists nvim && alias -g vimdiff='nvim -d'

# use ag instead of ack
alias ack=ag

# dd
alias dd='sudo dd bs=4M status=progress'
alias df='df -h'

# add sudo
alias cfdisk 'sudo cfdisk'
alias cgdisk 'sudo cgdisk'
alias du 'sudo du -h'
alias fdisk 'sudo fdisk'
alias fstrim 'sudo fstrim'
alias gdisk 'sudo gdisk'
alias hdparm 'sudo hdparm'
alias lsmod 'sudo lsmod'
alias mkinitcpio 'sudo mkinitcpio'
alias mkfs.ext4 'sudo mkfs.ext4'
alias mkfs.ext3 'sudo mkfs.ext3'
alias mkfs.ext2 'sudo mkfs.ext2'
alias modprobe 'sudo modprobe'
alias mount 'sudo mount'
alias rfkill 'sudo rfkill'
alias rmmod 'sudo rmmod'
alias skill 'sudo kill'
alias skillall 'sudo killall'
alias systemctl 'sudo systemctl'
alias umount 'sudo umount'
__command_exists gparted && alias gparted='sudo gparted'
__command_exists masscan && alias masscan='sudo masscan'
__command_exists minicom && alias minicom='sudo minicom'
__command_exists nmap && alias nmap='sudo nmap'

# ping
pn () { [[ ! "$*" ]] && ping -c 5 -i 0.2 8.8.8.8 || ping -c 5 -i 0.2 "$*" }

# tunnel local port
__command_exists lt        && alias lt='lt -l localhost -s none23'

# open ranger in curent directory by default
__command_exists ranger && rr () { [[ -n "$1" ]] && ranger "$*" || ranger "$(pwd)" }

for file in "$HOME"/.config/zsh/aliases.d/*.zsh; do source "$file"; done
