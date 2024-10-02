-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.animation_fps = 60
config.max_fps = 60
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- For example, changing the color scheme:
config.color_scheme = "iceberg-dark"
config.default_prog = { "pwsh" }
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- scrollbar
config.enable_scroll_bar = true
-- tab bar
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 25
-- config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

--others
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

-- and finally, return the configuration to wezterm
return config
