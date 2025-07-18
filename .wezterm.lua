-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- "Builtin Dark"
-- "cga"
-- "Dark Pastel"
config.color_scheme = "Homebrew"

config.font = wezterm.font("MonoLisa", { weight = "Regular", stretch = "Normal", style = "Normal" })

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)

config.default_prog = { "pwsh.exe" }

config.keys = {
	-- Switch to default workspace
	{
		key = "y",
		mods = "CTRL|SHIFT",
		action = act.SwitchToWorkspace({
			name = "work",
		}),
	},
	{
		key = "u",
		mods = "CTRL|SHIFT",
		action = act.SwitchToWorkspace({
			name = "personal",
		}),
	},
	{
		key = "i",
		mods = "CTRL|SHIFT",
		action = act.SwitchToWorkspace({
			name = "misc",
		}),
	},
}

wezterm.on("gui-startup", function()
	-- Start with the work workspace
	local _, _, work_window = mux.spawn_window({
		cwd = "D:\\Files\\workspaces",
		workspace = "work",
		args = {
			"pwsh.exe",
			"-NoExit",
			"-Command",
			"cd \\Files\\workspaces\\work\\repo1; wezterm cli set-tab-title repo1",
		},
	})

	-- Work tabs
	local work_cmds = {
		{
			args = {
				"pwsh.exe",
				"-NoExit",
				"-Command",
				"cd \\Files\\workspaces\\work\\repo2; wezterm cli set-tab-title repo2",
			},
		},
		{
			args = {
				"pwsh.exe",
				"-NoExit",
				"-Command",
				"cd \\Files\\workspaces\\work\\repo3; wezterm cli set-tab-title repo3",
			},
		},
	}

	for _, cmd in ipairs(work_cmds) do
		work_window:spawn_tab({
			args = cmd.args,
		})
	end

	work_window:gui_window():maximize()

	-- Personal workspace
	local _, _, personal_window = mux.spawn_window({
		cwd = "D:\\Files\\workspaces",
		workspace = "personal",
		args = {
			"pwsh.exe",
			"-NoExit",
			"-Command",
			"cd \\Files\\workspaces\\lysender\\repo1; wezterm cli set-tab-title repo1",
		},
	})

	local personal_cmds = {
		{
			args = {
				"pwsh.exe",
				"-NoExit",
				"-Command",
				"cd \\Files\\workspaces\\lysender\\repo2; wezterm cli set-tab-title repo2",
			},
		},
		{
			args = {
				"pwsh.exe",
				"-NoExit",
				"-Command",
				"cd \\Files\\workspaces\\lysender\\repo3; wezterm cli set-tab-title repo3",
			},
		},
	}

	for _, cmd in ipairs(personal_cmds) do
		personal_window:spawn_tab({
			args = cmd.args,
		})
	end

	-- Misc tabs
	local _, _, misc_window = mux.spawn_window({
		cwd = "C:\\Users\\joe",
		workspace = "misc",
		args = {
			"pwsh.exe",
			"-NoExit",
			"-Command",
			"wezterm cli set-tab-title misc",
		},
	})

	local misc_cmds = {
		{
			args = {
				"pwsh.exe",
				"-NoExit",
				"-Command",
				"cd \\Users\\joe\\AppData\\Local\\nvim; wezterm cli set-tab-title nvim",
			},
		},
		{
			args = {
				"pwsh.exe",
				"-NoExit",
				"-Command",
				"Set-Location -Path D:; cd \\Files\\workspaces\\config\\dotfiles; wezterm cli set-tab-title dotfiles",
			},
		},
	}

	for _, cmd in ipairs(misc_cmds) do
		misc_window:spawn_tab({
			args = cmd.args,
		})
	end
end)

-- and finally, return the configuration to wezterm
return config
