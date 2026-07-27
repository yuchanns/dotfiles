# Hyprland

Hyprland startup invokes only `~/.local/bin/hypringo-session`. The helper
starts `hypringo.service`, swww, and Eww idempotently. Do not start the legacy
`hypringo.sh` or `main.lua` at the same time, because that creates duplicate
state sources and competing window lifecycles.

Install the helper from the [Hypringo](../Hypringo) submodule:

```bash
install -Dm755 Hypringo/contrib/hyprland/hypringo-session ~/.local/bin/hypringo-session
systemctl --user enable hypringo.service
systemctl --user enable hypridle.service
```

`scripts/lock-screen.sh` handles repeated lock requests idempotently and
provides `--restore` for session-lock recovery. `portal-restart.sh` still runs
only once when the compositor starts.
