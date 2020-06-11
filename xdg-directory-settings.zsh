#!/bin/zsh

__command_exists () { hash "$1" 2>/dev/null }
__directory_exists () { [[ -d "$1" ]] }
__ensure_directory_exists () { __directory_exists "$1" || mkdir -p "$1" }
__alias_command_if_exists () { __command_exists "$1" && alias "$1"="$2" }

export ATOM_HOME="$XDG_DATA_HOME/atom"
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

__command_exists wakatime && __ensure_directory_exists "$XDG_CONFIG_HOME/wakatime"
__command_exists psql     && __ensure_directory_exists "$XDG_CONFIG_HOME/pg"
__command_exists psql     && __ensure_directory_exists "$XDG_CACHE_HOME/pg"

__alias_command_if_exists mitmproxy 'mitmproxy --set confdir="$XDG_CONFIG_HOME/mitmproxy"'
__alias_command_if_exists mitmweb   'mitmweb --set confdir="$XDG_CONFIG_HOME/mitmproxy"'
__alias_command_if_exists tmux      'tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
__alias_command_if_exists wget      'wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
