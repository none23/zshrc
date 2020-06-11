#!/bin/zsh

# chromium-tor
if __command_exists tor; then
  function __ensure_tor_is_running {
      if [[ -n "$(ps -ef | grep tor | grep -v grep)" ]]; then
          echo "tor already running"
      else
          sudo systemctl start tor.service
          echo "tor started"
      fi
  }

  if __command_exists chromium; then
    alias chromium-tor='__ensure_tor_is_running; chromium --proxy-server="socks5://localhost:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"'
  elif __command_exists chromium-browser; then
    alias chromium-tor='__ensure_tor_is_running; chromium-browser --proxy-server="socks5://localhost:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"'
  fi
fi



