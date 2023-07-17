local base = {}

-- "Buy" at the top bar / navbar
base.location_refresh = Location(914, 1119)
base.location_search_bar_focus = Location(475, 386)
base.location_search_bar_clear = Location(2489, 383)
base.location_search_bar_search = Location(2645, 385)

-- Lowest price shown on TS for the 1st item of the search
base.region_1st_item_lowest = Region(2186, 640, 294, 52)

-- Game button locations
base.ts_quick_menu_btn = Location(2498, 67)
base.ts_search_on_navbar = Location(479, 249)
base.game_confirm_exit_no = Location(1085, 1063)

return base