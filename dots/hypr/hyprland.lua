hl.on('hyprland.start', function ()
  hl.exec_cmd('dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP')
  hl.exec_cmd('systemctl --user start hyprpolkitagent')
  hl.exec_cmd('app2unit fcitx5')
  hl.exec_cmd('app2unit awww-daemon')
end)

hl.config({
  input = {
    kb_layout = 'us',
    kb_options = 'grp:ctrl_alt_toggle',
    repeat_rate = 100,
    repeat_delay = 300,
    scroll_factor = 1.4,
    sensitivity = -0.0725,
  },
  general = {
    border_size = 1,
    gaps_in = 4,
    gaps_out = 6,
    extend_border_grab_area = 8,
    allow_tearing = true,
    col = {
      active_border = 0x22ffffff,
      inactive_border = 0x22ffffff,
    },
    snap = {
      enabled = true,
      window_gap = 16,
      monitor_gap = 16,
    },
  },
  decoration = {
    rounding = 16,
    blur = {
      enabled = false
    },
    shadow = {
      enabled = false
    },
  },
  animations = {
    enabled = true
  },
  misc = {
    disable_hyprland_logo = false,
    disable_splash_rendering = false,
    animate_manual_resizes = false,
    enable_anr_dialog = false,
    enable_swallow = false,
    background_color = 0x00000000,
  },
  xwayland = {
    use_nearest_neighbor = false,
  },
  render = {
    direct_scanout = 1,
    expand_undersized_textures = false,
  },
  cursor = {
    no_hardware_cursors = 1
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})

local mod = 'SUPER'

hl.bind(mod .. ' + T', hl.dsp.exec_cmd('app2unit kitty'))
hl.bind(mod .. ' + E', hl.dsp.exec_cmd('app2unit zeditor -n'))
hl.bind(mod .. ' + F', hl.dsp.exec_cmd('app2unit nautilus -w'))
hl.bind(mod .. ' + B', hl.dsp.exec_cmd('app2unit blueberry'))
hl.bind(mod .. ' + M', hl.dsp.exec_cmd('app2unit missioncenter'))
hl.bind(mod .. ' + W', hl.dsp.exec_cmd('app2unit zen-browser'))

hl.bind(mod .. ' + P', hl.dsp.window.pin())

hl.bind(mod .. ' + SHIFT + S', hl.dsp.exec_cmd('hyprshot -m region'))
hl.bind(mod .. ' + SHIFT + D', hl.dsp.exec_cmd('hyprshot -m region --clipboard-only'))

hl.bind(mod .. ' + S', hl.dsp.exec_cmd('ags -i desktop request toggle-launcher'))

hl.bind(mod .. ' + Q', hl.dsp.window.close())
hl.bind(mod .. ' + V', hl.dsp.window.float({ action = 'toggle' }))
hl.bind(mod .. ' + J', hl.dsp.layout('togglesplit'))
hl.bind(mod .. ' + L', hl.dsp.window.fullscreen())
hl.bind(mod .. ' + C', hl.dsp.window.center())

hl.bind('CTRL + H', hl.dsp.focus({ direction = 'left' }))
hl.bind('CTRL + L', hl.dsp.focus({ direction = 'right' }))
hl.bind('CTRL + K', hl.dsp.focus({ direction = 'up' }))
hl.bind('CTRL + J', hl.dsp.focus({ direction = 'down' }))

hl.bind(mod .. ' + ALT + H', hl.dsp.window.swap({ direction = 'left' }))
hl.bind(mod .. ' + ALT + L', hl.dsp.window.swap({ direction = 'right' }))
hl.bind(mod .. ' + ALT + K', hl.dsp.window.swap({ direction = 'up' }))
hl.bind(mod .. ' + ALT + J', hl.dsp.window.swap({ direction = 'down' }))

hl.bind('ALT + H', hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind('ALT + L', hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind('ALT + K', hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind('ALT + J', hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. ' + ' .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. ' + LEFT', hl.dsp.focus({ workspace = '-1' }))
hl.bind(mod .. ' + RIGHT', hl.dsp.focus({ workspace = '+1' }))

hl.bind(mod .. ' + SHIFT + UP', hl.dsp.exec_cmd('wpctl set-volume -l 1.25 @DEFAULT_AUDIO_SINK@ 5%+'), { locked = true })
hl.bind(mod .. ' + SHIFT + DOWN', hl.dsp.exec_cmd('wpctl set-volume -l 1.25 @DEFAULT_AUDIO_SINK@ 5%-'), { locked = true })
hl.bind(mod .. ' + SHIFT + M', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'), { locked = true })
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume -l 1.25 @DEFAULT_AUDIO_SINK@ 5%+'), { locked = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'), { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd('playerctl play-pause'), { locked = true })
hl.bind('XF86AudioNext', hl.dsp.exec_cmd('playerctl next'), { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd('playerctl previous'), { locked = true })

hl.bind(mod .. ' + mouse:272', hl.dsp.window.drag())
hl.bind(mod .. ' + mouse:273', hl.dsp.window.resize())

hl.curve('easying', {
  type = 'bezier',
  points = {
    {0, 0.73},
    {0.22, 1.05}
  }
})

hl.animation({
  leaf = 'workspaces',
  enabled = true,
  speed = 2.25,
  bezier = 'easying',
  style = 'slide',
})

hl.animation({
  leaf = 'windows',
  enabled = true,
  speed = 1.45,
  bezier = 'easying',
  style = 'popin 35%',
})

local _ = select(2, pcall(dofile, os.getenv('HOME') .. '/.config/hypr/local.lua')) or {}
