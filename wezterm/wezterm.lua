local wz = require('wezterm')

local config = wz.config_builder()

----
----
--
--Apparence
config.color_scheme = 'AdventureTime'
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
    left = 10,
    right = 10,
    top = 30,
    bottom = 10,
}
config.font_size = 14
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85
config.window_background_gradient = {
    -- Can be "Vertical" or "Horizontal".  Specifies the direction
    orientation = 'Vertical',
    colors = {
        '#0f0c29',
        '#302b63',
        '#24243e',
    },
    -- Specifies the interpolation style to be used.
    -- "Linear", "Basis" and "CatmullRom" as supported.
    interpolation = 'Linear',
    -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
    blend = 'Rgb',
}
--tab_bar
--
config.window_frame = {
    font_size = 10,
    active_titlebar_bg = '#301934',
}
--
config.colors = {
    tab_bar = {
        -- The color of the strip that goes along the top of the window

        -- The active tab is the one that has focus in the window
        active_tab = {
            -- The color of the background area for the tab
            bg_color = '#100812',
            -- The color of the text for the tab
            fg_color = '#c0c0c0',

            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            intensity = 'Normal',

            -- Specify whether you want "None", "Single" or "Double" underline for
            underline = 'None',

            -- Specify whether you want the text to be rendered with strikethrough (true)
            strikethrough = false,
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = '#453048',
            fg_color = '#808080',
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over inactive tabs
        inactive_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true,
        },
    },
}

-------------
--------------
------------
-- Keybinding
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = '\"',
        mods = 'LEADER',
        action = wz.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '%',
        mods = 'LEADER|SHIFT',
        action = wz.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
        key = 'a',
        mods = 'LEADER|CTRL',
        action = wz.action.SendKey { key = 'a', mods = 'CTRL' },
    },
    {
        key = 'w',
        mods = 'CMD',
        action = wz.action.CloseCurrentPane { confirm = true },
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wz.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = wz.action.AdjustPaneSize { 'Down', 5 },
    },
    { key = 'k', mods = 'LEADER', action = wz.action.AdjustPaneSize { 'Up', 5 } },
    {
        key = 'l',
        mods = 'LEADER',
        action = wz.action.AdjustPaneSize { 'Right', 5 },
    },
}

-- intergration with zen mode neovim
wz.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wz.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wz.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return config
