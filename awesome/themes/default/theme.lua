local theme_assets              = require("beautiful.theme_assets")
local xresources                = require("beautiful.xresources")
local awful                     = require("awful")

local dpi                       = xresources.apply_dpi

local theme_path                = awful.util.get_configuration_dir() .. "/themes/default/"

local theme                     = {}

theme.font                      = "monospace bold 10"

theme.bg_normal                 = "#203"
theme.bg_focus                  = "#b6f" -- in menus
theme.bg_urgent                 = "#e44"
theme.bg_minimize               = "#444"
theme.bg_systray                = "#111111"

theme.fg_normal                 = "#c9f"
theme.fg_focus                  = "#ffffff"
theme.fg_urgent                 = "#ffffff"
theme.fg_minimize               = "#000"

theme.useless_gap               = 0 --.5--1.5--dpi(1.5)
theme.border_width              = 0
theme.border_normal             = "#4400bb" --"#0066bb"
theme.border_focus              = "#ff8844" --"#00ccff"
theme.border_marked             = "#882211"

theme.widget_background         = "#000000"
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
theme.tasklist_bg_focus         = "#408" --"#ff8800"-- window titles
theme.tasklist_fg_focus         = "#fff" -- window titles
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.taglist_bg_focus          = "#53f"

-- Generate taglist squares:
local taglist_square_size       = dpi(6)
theme.taglist_squares_sel       = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel     = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[border_color|border_width|shape|opacity]
theme.notification_font         = "freesans 9"
theme.notification_bg           = "#224455"
theme.notification_fg           = "#ccbbff"
theme.notification_border_color = "#5533ff"
theme.notification_border_width = dpi(4)
theme.notification_margin       = 8
theme.notification_width        = 512
theme.notification_icon_size    = 64
theme.notification_height       = 64 + theme.notification_margin * 2
theme.notification_opacity      = 0.8

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon         = theme_path .. "submenu.png"
--theme.menu_submenu_icon = "submenu.png"
theme.menu_height               = dpi(48)
theme.menu_width                = dpi(256)
theme.menu_border_color         = "#ff8844"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

-- theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

-- theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

-- theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

-- theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper                 = theme_path .. "background.png"

-- You can use your own layout icons like this:
-- theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
-- theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
-- theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
-- theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
-- theme.layout_max = themes_path.."default/layouts/maxw.png"
-- theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
-- theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
-- theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
-- theme.layout_tile = themes_path.."default/layouts/tilew.png"
-- theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )
theme.awesome_icon              = theme_path .. "icon.png"
theme.blahaj                    = theme_path .. "blahaj.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
