#!/bin/zsh

function __command_exists {
  hash "$1" 2>/dev/null
}

if __command_exists sshuttle; then
  function sshide {
    local __SHUTTLE_PIDFILE
    if [[ -a  __SHUTTLE_PIDFILE ]]; then
      echo 'sshuttle is already running'
      exit 1
    else
      sshuttle -r "$1" 0/0 --dns --daemon --pidfile "$__SHUTTLE_PIDFILE"
    fi
  }

  function sshide {
    local __SHUTTLE_PIDFILE
    if [[ -a __SHUTTLE_PIDFILE ]]; then
      echo 'sshuttle is already running'
      exit 1
    else
      sshuttle -r "$1" 0/0 --dns --verbose --pidfile "$__SHUTTLE_PIDFILE"
    fi
  }
fi

