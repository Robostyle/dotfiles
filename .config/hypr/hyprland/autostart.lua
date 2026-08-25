-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--

local defaults = require("hyprland/defaults")

hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("hyprpolkitagent")

	hl.exec_cmd("uwsm app -- gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("uwsm app -- wl-paste --primary --watch wl-copy")
	hl.exec_cmd("uwsm app -- cursor-clip --daemon")
	hl.exec_cmd("uwsm app -- hypridle --config $HOME/.config/hypr/hypridle-hyprland.conf")
	hl.exec_cmd("uwsm app -- elephant")
	hl.exec_cmd("uwsm app -- walker --gapplication-service")
	hl.exec_cmd("uwsm app -- " .. defaults.programs.terminal)
	hl.exec_cmd("uwsm app -- " .. defaults.programs.browser)
end)
