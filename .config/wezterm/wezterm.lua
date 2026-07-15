local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function get_color_scheme()
	if wezterm.gui.get_appearance():find("Dark") then
		return "Rosé Pine (Gogh)"
	else
		return "Rosé Pine Dawn (Gogh)"
	end
end

wezterm.on("update-status", function(window)
	local overrides = window:get_config_overrides() or {}

	local current_scheme = get_color_scheme()
	if overrides.color_scheme ~= current_scheme then
		overrides.color_scheme = current_scheme
		window:set_config_overrides(overrides)
	end
end)

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font("JetBrains Mono Nerd Font")

config.color_scheme = get_color_scheme()

config.scrollback_lines = 100000

return config
