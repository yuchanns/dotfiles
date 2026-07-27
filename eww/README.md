# Eww

This configuration uses [Hypringo](../Hypringo) as its single state stream.
Workspaces, media, audio, weather, GitHub notifications, batteries, and
backlights no longer start independent `defpoll` processes. Eww consumes the
Hypringo snapshot and performs allowed operations through typed dispatch.

Initialize and build the submodule:

```bash
git submodule update --init --recursive
(cd Hypringo && luamake -mode release)
```

Install the runtime, Eww listeners, session helper, and user service:

```bash
install -Dm755 Hypringo/build/bin/hypringo ~/.local/bin/hypringo
install -Dm755 Hypringo/contrib/eww/hypringo-listen ~/.local/bin/hypringo-eww-listen
install -Dm755 Hypringo/contrib/eww/hypringo-cover-listen ~/.local/bin/hypringo-cover-listen
install -Dm755 Hypringo/contrib/eww/hypringo-bars ~/.local/bin/hypringo-bars
install -Dm755 Hypringo/contrib/eww/hypringo-eww-session ~/.local/bin/hypringo-eww-session
install -Dm755 Hypringo/contrib/hyprland/hypringo-session ~/.local/bin/hypringo-session
install -Dm755 Hypringo/contrib/systemd/hypringo-github-start ~/.local/bin/hypringo-github-start
install -Dm644 Hypringo/contrib/systemd/hypringo.service ~/.config/systemd/user/hypringo.service
install -Dm644 Hypringo/contrib/systemd/hypringo-eww.service ~/.config/systemd/user/hypringo-eww.service
install -Dm755 eww/scripts/eww-desktop-action ~/.local/bin/eww-desktop-action
```

`eww.yuck` includes the initial schema from `hypringo.yuck` in this directory.
`config.lua` and GitHub credentials are intentionally absent from dotfiles.
Create the local configuration from `Hypringo/example/config.lua`, and keep
the token in an environment variable or the system keyring. Never commit a
token to this repository.

The managed Eww session creates one `bar` instance per monitor from the
Hypringo snapshot and removes it when that monitor disappears. Each bar keeps
one compact, continuous surface while its three-column layout holds weather
and media at the physical center independently of the left and right widths.

The bar has a fixed height of 40 px. Album art is 24 px with 4 px of vertical
spacing. Battery and brightness controls are conditional on hardware
availability, so the same configuration works on desktops and laptops.
Volume, brightness, and power controls remain compact until hover reveals their
inline actions. Reboot and poweroff require a second, explicit confirmation
click. `eww-desktop-action` validates the finite popup, workspace-scroll,
GitHub-link, and power action set before invoking the corresponding trusted
command.
