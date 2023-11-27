#!/bin/zsh

__command_exists () { hash "$1" 2>/dev/null }
__directory_exists () { [[ -d "$1" ]] }
__ensure_directory_exists () { __directory_exists "$1" || mkdir -p "$1" }
__alias_command_if_exists () { __command_exists "$1" && alias "$1"="$2" }

export ACKRC="$HOME/.config/ack/ackrc"
export ANDROID_SDK_HOME="$HOME/.config/android"
export ANDROID_HOME="$HOME/.config/android"
export ATOM_HOME="$HOME/.local/share/atom"
export AWS_CONFIG_FILE="$HOME/.config/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$HOME/.config/aws/credentials"
export CARGO_HOME="$HOME/.local/share/cargo"
export DOCKER_CONFIG="$HOME/.config/docker"
export INPUTRC="$HOME/.config/readline/inputrc"
export IPYTHONDIR="$HOME/.config/jupyter"
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export NODE_REPL_HISTORY="$HOME/.local/share/node_repl_history"
export PGPASSFILE="$HOME/.config/pg/pgpass"
export PGSERVICEFILE="$HOME/.config/pg/pg_service.conf"
export PSQLRC="$HOME/.config/pg/psqlrc"
export PSQL_HISTORY="$HOME/.cache/pg/psql_history"
export SCREENRC="$HOME/.config/screen/screenrc"
export TMUX_TMPDIR="/run/user/$(id -u)"
export WAKATIME_HOME="$HOME/.config/wakatime"
export WGETRC="$HOME/.config/wgetrc"

__command_exists wakatime && __ensure_directory_exists "$HOME/.config/wakatime"
__command_exists psql     && __ensure_directory_exists "$HOME/.config/pg"
__command_exists psql     && __ensure_directory_exists "$HOME/.cache/pg"

__alias_command_if_exists mitmproxy 'mitmproxy --set confdir="$HOME/.config/mitmproxy"'
__alias_command_if_exists mitmweb   'mitmweb --set confdir="$HOME/.config/mitmproxy"'
__alias_command_if_exists tmux      'tmux -f "$HOME/.config/tmux/tmux.conf"'
__alias_command_if_exists wget      'wget --hsts-file="$HOME/.cache/wget-hsts"'
