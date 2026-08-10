-- ============================================================= #
--  ██████╗ ██████╗  ██████╗██╗  ██╗██████╗ ██╗███████╗████████╗ #
-- ██╔═══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██║██╔════╝╚══██╔══╝ #
-- ██║   ██║██████╔╝██║     ███████║██████╔╝██║███████╗   ██║    #
-- ██║   ██║██╔══██╗██║     ██╔══██║██╔══██╗██║╚════██║   ██║    #
-- ╚██████╔╝██║  ██║╚██████╗██║  ██║██║  ██║██║███████║   ██║    #
--  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝    #
--               █▀▄ █▀█ ▀█▀   █▀▀ ▀█▀ █   █▀▀ █▀▀               #
--               █ █ █ █  █    █▀▀  █  █   █▀▀ ▀▀█               #
--               ▀▀  ▀▀▀  ▀    ▀   ▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀               #
-- ============================================================= #

-- ==== VARIABLES ============================== #

-- ==== CORE KEYBINDS ========================== #

hl.bind("SUPER + A", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("CTRL + F11", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty --class kitty-floating"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))

-- ==== APPLICATIONS =========================== #

hl.bind("CTRL + F10", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("zeditor"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("discord"))

-- ==== AUDIO CONTROL ========================== DangerClose17!

hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
-- bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("ALT + Y", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/audioswitcher.sh"))

-- ==== MONITOR SWAP CONTROL =================== #

-- Monitor Switching
--   All -a/up, Top -t/down, Bottom -b/right, Top and Bottom -d/left
hl.bind("SHIFT + ALT + Up", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/monitorconfigs.sh -a"))
hl.bind("SHIFT + ALT + Right", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/monitorconfigs.sh -b"))
hl.bind("SHIFT + ALT + Down", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/monitorconfigs.sh -t"))
hl.bind("SHIFT + ALT + Left", hl.dsp.exec_cmd("sh " .. os.getenv("HOME") .. "/.config/hypr/scripts/monitorconfigs.sh -d"))

-- ==== SYSTEM CONTROL ========================= #

hl.bind("SUPER + CTRL + P", hl.dsp.exit())
hl.bind("SUPER + SHIFT + H", hl.dsp.exec_cmd("hyperctl reload"))
hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("dms ipc call bar toggle index 0; dms restart"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("sleep 5 && hyprctl dispatch dpms off"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- ==== WINDOW MANAGEMENT ====================== #
-- Force Quit
hl.bind("SUPER + Q", hl.dsp.window.close())
-- Quit active window and all open instances
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow| grep pid| tr -d 'pid:'| xargs kill"))
-- Toggle Fullscreen
hl.bind("ALT + M", hl.dsp.window.fullscreen())
-- Toggle Floating app
hl.bind("SUPER + ALT + up", hl.dsp.window.float())

-- SIZING & LAYOUT

hl.bind("SUPER + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true, continuous = true }))
hl.bind("SUPER + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true, continuous = true }))

-- MOUSE CONTROL
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ==== WINDOW NAVIGATION ====================== #

-- FOCUS NAVIATION
hl.bind("SUPER + S", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + E", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + D", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + F", hl.dsp.focus({ direction = "right" }))

-- WINDOW MOVEMENT
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + E", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + D", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.move({ direction = "r" }))

-- ==== WORKSPACE NAVIGATION =================== #

-- SPECIFIC
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))

-- NEXT / PREVIOUS
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + down", hl.dsp.focus({ workspace = "e-1" }))

-- MOVE WINDOWS TO WORKSPACES
-- SPECIFIC
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))

-- NEXT / PREVIOUS
hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + mouse_up", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "r+1" }))

-- ==== Screenshots ============================ #

hl.bind("CTRL + Print", hl.dsp.exec_cmd("grimblast --notify copysave area"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast --notify copysave active"))
hl.bind("SHIFT + ALT + Print", hl.dsp.exec_cmd("--notify grimblast copysave screen"))
hl.bind("SHIFT + CTRL + Up", hl.dsp.exec_cmd("wl-paste| satty -f-"))
