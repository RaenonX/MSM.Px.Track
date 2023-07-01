-- https://ankulua.boards.net/thread/181/api-quick-reference
actions = require(scriptPath() .. "mod/actions")
coordinates = require(scriptPath() .. "mod/coordinates")
configs = require(scriptPath() .. "mod/configs")
functions = require(scriptPath() .. "mod/functions")

Settings:set("MinSimilarity", 0.8)

local function main_px_check(item_name)
    local api_response = nil

    -- Click on search bar (in search page)
    actions.click_search_bar_focus()

    -- > Note that `type()` touches clipboard, 
    -- > so it's best that this script doesn't run on emulator
    -- Type item name
    type(item_name)
    functions.random_wait(configs.type_wait_sec)

    -- Click on search
    -- > Need to click twice, because the 1st clicks off text input
    -- > 2nd executes the search
    actions.click_search_execute()
    actions.click_search_execute()

    -- Check the price
    local px = actions.px_ocr(coordinates.region_1st_item_lowest)

    -- Send it to API
    if px ~= nil then
        toast(item_name .. ": " .. px)
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
    for _, item_name in ipairs(configs.items_to_check) do
        current_check_target = item_name
        repeat
            current_check_target = main_px_check(current_check_target)
        until current_check_target == nil or current_check_target == ""
    end
end
