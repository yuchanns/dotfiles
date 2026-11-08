-- Migrated from the user's hyprland.conf for Hyprland 0.57.
local terminal = "wezterm start --always-new-process"
local launcher = 'fuzzel --prompt "  "'

hl.monitor({ output = "", mode = "preferred", position = "0x0", scale = 1 })
hl.config({
    input = {
        follow_mouse = 0,
        natural_scroll = true,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            clickfinger_behavior = true,
            disable_while_typing = true,
        },
    },
    general = {
        border_size = 2,
        gaps_out = { top = 63, right = 20, bottom = 16, left = 20 },
        col = { active_border = 0xff5e81ac, inactive_border = 0x66333333 },
    },
    decoration = {
        rounding = 10,
        blur = { size = 1, passes = 2, new_optimizations = true, enabled = true },
        active_opacity = 0.95,
        inactive_opacity = 0.9,
        dim_inactive = true,
        dim_strength = 0.15,
        shadow = {
            range = 10,
            render_power = 4,
            color = 0x769ff0ff,
            color_inactive = 0x50000000,
            enabled = true,
        },
    },
    misc = { mouse_move_enables_dpms = true },
    debug = { disable_logs = false, disable_time = false },
})

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
for key, direction in pairs({ H = "left", L = "right", K = "up", J = "down" }) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=sway flameshot gui"))
hl.bind("SUPER + CTRL + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-recorder.sh"))
for key, command in pairs({
    XF86MonBrightnessUp = "light -A 5",
    XF86MonBrightnessDown = "light -U 5",
    XF86AudioLowerVolume = "volumectl down",
    XF86AudioRaiseVolume = "volumectl up",
    XF86AudioMute = "volumectl toggle",
}) do
    hl.bind(key, hl.dsp.exec_cmd(command), { locked = true, repeating = true })
end

hl.window_rule({ name = "apply_wechat_windows", match = { class = "wechat" }, float = true })
hl.window_rule({
    name = "apply_dolphin", match = { class = "org.kde.dolphin" },
    float = true, size = { 800, 500 }, move = { "monitor_w * 0.25", "monitor_h * 0.25" },
})
hl.window_rule({
    name = "apply_flameshot", match = { class = "flameshot" },
    float = true, move = { 0, 0 }, pin = true, border_size = 0, no_blur = true, no_shadow = true,
})
hl.window_rule({
    name = "apply_save_dialog", match = { title = "^(.*Save\\ As.*)$" },
    float = true, size = { 800, 500 },
})
hl.window_rule({
    name = "apply_confirmo", match = { class = "^(confirmo)$" },
    float = true, pin = true, border_size = 0, no_shadow = true, no_blur = true,
    no_focus = true, no_dim = true, opacity = "1.0 override 1.0 override",
})
hl.window_rule({
    name = "apply_wechat", match = { class = "^(weixin.*)$" },
    no_shadow = true, no_blur = true, no_dim = true,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("mako --config ~/.config/mako/config")
    hl.exec_cmd("~/.config/hypr/scripts/portal-restart.sh")
    hl.exec_cmd("~/.local/bin/hypringo-session")
    hl.exec_cmd("fcitx5 -r -d")
    hl.exec_cmd("XDG_CURRENT_DESKTOP=sway flameshot")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("/opt/1Password/1password --silent")
end)
