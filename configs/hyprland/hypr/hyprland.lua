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

-- ==== CONFIG FILES =========================== #

require('config.monitors.all')
require('config.workspaces.all')
require("config.decorations")
require("config.keybindings")
require("config.windowrules")
require("/mnt/Storage/Config Files/dotfiles/custom.lua")

-- ==== ENVRIONMENT VARIABLES ================== #

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME", "kvantum")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("TERMINAL", "kitty")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", 24)
hl.env("DRI_PRIME", 1)
hl.env("WLR_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")
hl.env("DEFAULT_TARGET_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")


-- ==== AUTOSTART ============================== #

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("bash -c \"wl-paste --watch cliphist store &\"")
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    hl.exec_cmd("sleep 1 && dms run")
end)

-- Exec (run every reload)
hl.on("config.reloaded", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")
end)

-- ==== INPUT CONFIGURATION ==================== #

hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = true,
        },
    },
})

-- === PLUGINS ================================= #

-- === MISC ==================================== #

hl.config({
    misc = {
        mouse_move_enables_dpms = true,
    },
})
