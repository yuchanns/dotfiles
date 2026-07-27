#!/usr/bin/env bash
set -euo pipefail

restore=false
if [[ "${1:-}" == "--restore" ]]; then
  restore=true
fi

if pgrep -x hyprlock >/dev/null; then
  exit 0
fi

if [[ "$restore" == true ]]; then
  hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1' >/dev/null 2>&1 || true
fi

if hyprctl --instance 0 'dispatch exec hyprlock' >/dev/null 2>&1; then
  exit 0
fi

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
if [[ -z "${WAYLAND_DISPLAY:-}" && -S "$XDG_RUNTIME_DIR/wayland-1" ]]; then
  export WAYLAND_DISPLAY=wayland-1
fi

exec hyprlock
