local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { '/usr/bin/fish', '-l' }

-- config.color_scheme = 'Mono Theme (terminal.sexy)'
config.color_scheme = 'rose-pine'
config.font = wezterm.font {
	family = 'Monaspace Argon Var',
	harfbuzz_features = {
		'ss01=1',
		'ss02=1',
		'ss03=1',
		'ss04=1',
		'ss05=1',
		'ss06=1',
		'ss07=1',
		'ss08=1',
		'calt=1',
		'dlig=1'
	}
}


return config
