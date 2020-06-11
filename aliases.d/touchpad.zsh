#!/bin/zsh

# turn touchpad on/off (if found)
if [[ -n "$(cat /proc/bus/input/devices | grep -i name | grep -iP 'touch(pad)?')" ]]; then
  alias toff='xinput disable Elan\ Touchpad'
  alias tonn='xinput enable Elan\ Touchpad'
  function ton {
      local LOCKFILE
      LOCKFILE="$XDG_RUNTIME_DIR/.touchpad-on.lock"
      if [[ -a "$LOCKFILE" ]]; then
          xinput disable Elan\ Touchpad
          rm "$LOCKFILE"
      else
          xinput enable Elan\ Touchpad
          touch "$LOCKFILE"
      fi
  }
fi
