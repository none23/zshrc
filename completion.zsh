#!/bin/zsh

zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/rc"
zstyle ":completion:*:commands" rehash 1 # do not trust completions cache
zstyle ':acceptline' rehash true
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data
zstyle nocompwarn true
autoload -Uz compinit
compinit
setopt completealiases
