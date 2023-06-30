-- https://ankulua.boards.net/thread/181/api-quick-reference
actions = require(scriptPath() .. "mod/actions")
coordinates = require(scriptPath() .. "mod/coordinates")
configs = require(scriptPath() .. "mod/configs")
functions = require(scriptPath() .. "mod/functions")

Settings:set("MinSimilarity", 0.8)

while (true) do
    for _, item_name in ipairs(configs.items_to_check) do
        -- Click on search bar (in search page)
        functions.random_click(coordinates.location_search_bar_focus)
        functions.random_wait(configs.click_wait_sec)

        -- (Can't use type here because emulator conflict with local clipboard)
        -- Type item name
        type(item_name)
        functions.random_wait(configs.type_wait_sec)

        -- Click on search
        -- > Need to click twice, because the 1st clicks off text input
        -- > 2nd executes the search
        functions.random_click(coordinates.location_search_bar_search)
        functions.random_wait(configs.click_wait_sec)
        functions.random_click(coordinates.location_search_bar_search)
        functions.random_wait(configs.click_wait_sec)

        -- Check the price
        local px = actions.px_ocr(coordinates.region_1st_item_lowest)

        -- Send it to API
        if px ~= nil then
            toast(item_name .. ": " .. px)
            actions.upload_px(item_name, px)
        end

        -- Click on search bar (in item list)
        functions.random_click(coordinates.location_search_bar_focus)
        functions.random_wait(configs.click_wait_sec)

        -- Clear the search bar
        functions.random_click(coordinates.location_search_bar_clear)
        functions.random_wait(configs.click_wait_sec)
    end
end
