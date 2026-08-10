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

-- ==== TERMINAL RULES ========================= #

-- Floating centered kitty terminal
hl.window_rule({
    name  = "kitty-floating",
    match = {
        class = "kitty-floating"
    },
    float = true,
    center = true,
    size = {1200, 1000},
})

-- ==== APPLICATIONS =========================== #

-- OBS
hl.window_rule({
    match = { class = "(com\\.obsproject\\.Studio)" },
    float = true,
    size = {950, 875},
    move = {2415, 85},
})

hl.window_rule({ match = { class = "(discord)" }, workspace = 6 })
hl.window_rule({ match = { class = "(gnome-calculator)" }, float = true })
hl.window_rule({ match = { class = "(pavucontrol)" }, float = true })
hl.window_rule({ match = { class = "(galculator)" }, float = true })
hl.window_rule({ match = { class = "(blueman-manager)" }, float = true })
hl.window_rule({ match = { class = "(org.gnome.FileRoller)" }, float = true })
hl.window_rule({ match = { class = "(org.gnome.Calculator)" }, float = true })
hl.window_rule({ match = { class = "(com.gabm.satty)" }, float = true, size = {800, 800} })

-- ==== GAMES ================================== #

-- HoTS
hl.window_rule({ match = { title = "(Heroes of the Storm)" }, fullscreen = true })

-- Stardew Valley
hl.window_rule({ match = { class = "(StardewModdingAPI)" }, fullscreen = true })
hl.window_rule({ match = { class = "(steam_app_1086940)" }, fullscreen = true })

--SMAPI Bullshit
hl.window_rule({ match = { class = "^(XTerm)$" }, float = true, size = {1, 1} })

--WoW
hl.window_rule({ match = { title = "(World of Warcraft)" }, fullscreen = true })
-- Console Port Testing
--  Phone
-- hl.window_rule({ match = { title = "(World of Warcraft)" }, float = true, size = "1620 1392" })
--  Steamdeck
-- hl.window_rule({ match = { title = "(World of Warcraft)" }, float = true, size = "1280 800" })

-- TSM
hl.window_rule({
    match = { title = "^TradeSkillMaster.*" },
    workspace = 6,
    no_initial_focus = true,
    float = true,
    opacity = 0,
    no_shadow = true,
    no_dim = true,
    no_blur = true,
    move = {1, 1},
})

-- ==== DIALOGUE POP-UP ======================== #

-- File Portal Dialog
hl.window_rule({
    name  = "file-portal-dialog",
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    center = true,
    size = {"monitor_w * 0.6", "monitor_h * 0.8"}
})

-- Hyprland Share Picker
hl.window_rule({
    name  = "share-picker-dialog",
    match = { class = "hyprland-share-picker" },
    float = true,
    center = true,
    size = {"monitor_w * 0.6", "monitor_h * 0.8"}
})

-- ==== SPECIAL CASES ========================== #

-- Zen Browser Picture-in-Picture
hl.window_rule({
    match = {
        class = "(zen-browser-bin)",
        title = "(Picture-in-Picture)",
    },
    float = true,
})

-- Global opacity for unfocused tiled windows
hl.window_rule({
    match = {
        float = 0,
        focus = 0,
    },
    opacity = "0.95 0.95",
})
