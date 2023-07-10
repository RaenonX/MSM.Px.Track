-- https://ankulua.boards.net/thread/181/api-quick-reference
actions = require(scriptPath() .. "mod/actions")
coordinates = require(scriptPath() .. "mod/coordinates")
configs = require(scriptPath() .. "mod/configs")
functions = require(scriptPath() .. "mod/functions")

configs.initialize()

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

local loop_timer = Timer()
local current_check_target = nil

-- Take a screenshot before the script starts
-- For recovery from AnkuLua being killed
actions.take_screenshot("startup")

while true do
    item_count, tracking_items = actions.get_tracking_items()
    loop_timer:set()

    for _, item_name in ipairs(tracking_items) do
        current_check_target = item_name
        repeat
            current_check_target = main_px_check(current_check_target)
        until current_check_target == nil or current_check_target == ""
    end

    actions.upload_loop_sec(item_count, loop_timer:check())
end
