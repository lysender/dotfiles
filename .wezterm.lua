-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- "Builtin Dark"
-- "cga"
-- "Dark Pastel"
config.color_scheme = "Homebrew"

config.font = wezterm.font("MonoLisa", { weight = "Regular", stretch = "Normal", style = "Normal" })

wezterm.on("gui-startup", function()
	-- Opens a window with its first tab
	local _, _, window = mux.spawn_window({
		cwd = "D:\\Files\\workspaces",
		args = {
			"cmd.exe",
			"/k",
			"cd \\Files\\workspaces\\project-1 && wezterm cli set-tab-title project-1",
		},
	})

	-- The rest of the tabs
	-- For some reason, passing cwd to the spawn_tab function doesn't work
	-- so we have to use the cd command in the args
	local cmds = {
		{
			args = {
				"cmd.exe",
				"/k",
				"cd \\Files\\workspaces\\project-2 && wezterm cli set-tab-title project-2",
			},
		},
		{
			args = {
				"cmd.exe",
				"/k",
				"cd \\Files\\workspaces\\project-3 && wezterm cli set-tab-title project-3",
			},
		},
	}

	for _, cmd in ipairs(cmds) do
		window:spawn_tab({
			args = cmd.args,
		})
	end

	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
