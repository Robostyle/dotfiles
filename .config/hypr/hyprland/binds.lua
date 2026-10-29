---------------------
---- KEYBINDINGS ----
---------------------

local defaults = require("hyprland/defaults")

hl.config({
	binds = {
		workspace_back_and_forth = true,
	},
})

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("uwsm app -- " .. defaults.programs.terminal))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("uwsm app -- " .. defaults.programs.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- " .. defaults.programs.browser))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cursor-clip"))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("toggle"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

-- Move focus with mainMod
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move window to workspace
hl.bind(mainMod .. " + ALT + SHIFT + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + ALT + SHIFT + L", hl.dsp.window.move({ monitor = "r" }))

-- Move workspace to monitor
hl.bind(mainMod .. " + ALT + H", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.workspace.move({ monitor = "r" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scrolling layout binds
hl.bind(mainMod .. " + CTRL + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.layout("swapcol r"))

hl.bind(mainMod .. " + R", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + COMMA", hl.dsp.layout("consume"))
hl.bind(mainMod .. " + PERIOD", hl.dsp.layout("expel"))
hl.bind(mainMod .. " + C", hl.dsp.layout("center"))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Screenshots
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" -t ppm - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date "+%Y%m%d-%H:%M:%S").png'
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		[[hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - - | satty --filename -]]
	)
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Mouse dragging & resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--
-- Noctalia
--

local ipc = "noctalia msg "

-- Core binds
hl.bind(mainMod .. "+ Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+ ALT + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "+ ALT + COMMA", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind(mainMod .. " + ALT + U", hl.dsp.exec_cmd(ipc .. "session lock"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))
