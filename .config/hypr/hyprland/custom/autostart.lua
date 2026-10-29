hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- coolercontrol --disable-gpu")
	hl.exec_cmd(
		"gdbus wait --session org.kde.StatusNotifierWatcher && uwsm app -p TimeoutStopSec=2s -- openrgb --startminimized --profile Main"
	)
end)
