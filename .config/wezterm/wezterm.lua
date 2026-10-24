local wezterm = require "wezterm"

local config = wezterm.config_builder()
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = true
config.enable_tab_bar = false
config.font = wezterm.font_with_fallback {
  { family = "JetBrains Mono", weight = "Medium" },
  "Noto Sans Mono CJK JP",
}
config.font_size = 13
config.force_reverse_video_cursor = true
config.front_end = "OpenGL"
config.initial_cols = 100
config.initial_rows = 32
config.keys = {
  {
    key = "V",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom "Clipboard",
  },
}
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

wezterm.add_to_config_reload_watch_list(wezterm.config_dir .. "/colors")
local theme = io.open(wezterm.config_dir .. "/colors/noctalia.toml", "r")
if theme ~= nil then
  config.color_scheme = "noctalia"
  theme:close()
end

return config
