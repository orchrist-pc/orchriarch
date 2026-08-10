
---@module 'hl'

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

-- source = ~/.config/Ax-Shell/config/hypr/colors.conf -> requires manual conversion
-- local colors = require("Ax_Shell.config.hypr.colors")
-- TODO: convert ~/.config/Ax-Shell/config/hypr/colors.conf to .lua and use require()

-- BACKGROUND

hl.config({
    background = {
        path = "~/.current.wall",
        --path to background image
        blur_passes = 3,
        blur_size = 3,
        contrast = 1.0,
        brightness = 0.5,
        vibrancy = 0.0,
        vibrancy_darkness = 0.0,
    },
})

-- GENERAL

hl.config({
    general = {
        grace = 0,
        hide_cursor = true,
    },
})

-- INPUT FIELD

hl.config({
    input-field = {
        size = { 256, 48 },
        outline_thickness = 0,
        dots_size = 0.2,
        -- Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.5,
        -- Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true,
        outer_color = "rgba(00000000)",
        inner_color = { "rgba(0", 0, 0, "1)" },
        font_color = "rgb(local_var_foreground)",
        fail_color = "rgb(local_var_error)",
        check_color = "rgb(local_var_tertiary)",
        capslock_color = "rgb(local_var_secondary)",
        fade_on_empty = false,
        font_family = "Iosevka Nerd Font",
        placeholder_text = "...",
        --text for input password
        hide_input = false,
        position = { 0, -100 },
        halign = "center",
        valign = "center",
        shadow_passes = 1,
        shadow_size = 5,
        shadow_boost = 0.5,
    },
})
-- NOTE: Section 'input-field' may be a plugin or custom section; verify the output

-- TIME

hl.config({
    label = {
        text = "cmd[update:1000] echo $(date + %H:%M:%S )",
        color = "rgb(local_var_foreground)",
        font_size = 14,
        font_family = "Iosevka Nerd Font Bold",
        position = { 0, -150 },
        halign = "center",
        valign = "center",
        shadow_passes = 1,
        shadow_size = 5,
        shadow_boost = 0.5,
    },
})
-- NOTE: Section 'label' may be a plugin or custom section; verify the output

-- USER

hl.config({
    label = {
        text = "cmd[update:1000] echo " .. os.getenv("USER") .. "@$(hostname)",
        color = "rgb(local_var_foreground)",
        font_size = 14,
        font_family = "Iosevka Nerd Font Bold Italic",
        position = { 0, -50 },
        halign = "center",
        valign = "center",
        shadow_passes = 1,
        shadow_size = 5,
        shadow_boost = 0.5,
    },
})
-- NOTE: Section 'label' may be a plugin or custom section; verify the output

-- PICTURE

hl.config({
    image = {
        path = ".face.icon",
        size = 200,
        position = { 0, 75 },
        halign = "center",
        valign = "center",
        border_size = 3,
        border_color = "rgb(local_var_primary)",
        shadow_passes = 1,
        shadow_size = 5,
        shadow_boost = 0.5,
    },
})
-- NOTE: Section 'image' may be a plugin or custom section; verify the output
