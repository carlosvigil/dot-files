local wezterm = require 'wezterm'
local config = {}

config.enable_wayland = false

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.default_prog = { '/usr/bin/fish', '-l' }

-- config.color_scheme = 'Mono Theme (terminal.sexy)'
config.color_scheme = 'rose-pine'
config.font = wezterm.font {
	family = 'MonaspiceNe Nerd Font Mono',
	harfbuzz_features = {
		'calt=1',
		'liga=1',
		'dlig=1',
		'ss01=1',
		'ss02=1',
		'ss03=1',
		'ss04=1',
		'ss05=1',
		'ss06=1',
		'ss07=1',
		'ss08=1',
	}
}


return config
