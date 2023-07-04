-- https://ankulua.boards.net/thread/181/api-quick-reference
actions = require(scriptPath() .. "mod/actions")
coordinates = require(scriptPath() .. "mod/coordinates")
configs = require(scriptPath() .. "mod/configs")
functions = require(scriptPath() .. "mod/functions")

Settings:set("MinSimilarity", 0.8)
-- Created on 2960 x 1440 (Note 8)
Settings:setScriptDimension(true, 2960)
Settings:setCompareDimension(true, 2960)

local function main_px_check(item_name)
    local api_response = nil

    -- Navigate to item page from search page
    actions.navigate_to_item_from_search(item_name)

    -- Check the price
    local px = actions.px_ocr(coordinates.region_1st_item_lowest)

    -- Send it to API
    if px ~= nil then
        -- Returns "" for backend returning `Ok()`
        api_response = actions.upload_px(item_name, px)
    end

    -- Click on search bar (in item list)
    actions.click_search_bar_focus()

    -- Clear the search bar
    actions.click_search_bar_clear()

    return api_response
end

local current_check_target = nil

while true do
    tracking_items = actions.get_tracking_items()

    for _, item_name in ipairs(tracking_items) do
        current_check_target = item_name
        repeat
            current_check_target = main_px_check(current_check_target)
        until current_check_target == nil or current_check_target == ""
    end
end
