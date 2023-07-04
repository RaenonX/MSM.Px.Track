-- https://ankulua.boards.net/thread/181/api-quick-reference
actions = require(scriptPath() .. "mod/actions")
coordinates = require(scriptPath() .. "mod/coordinates")

Settings:set("MinSimilarity", 0.8)
-- Created on 2960 x 1440 (Note 8)
Settings:setScriptDimension(true, 2960)
Settings:setCompareDimension(true, 2960)

local function snipe_px_check(item_name)
    actions.snipe_px_refresh()

    -- Check the price
    local px = actions.px_ocr(coordinates.region_1st_item_lowest)

    -- Send it to API
    if px ~= nil then
        actions.upload_px(item_name, px)
    end
end

-------------- Start of Main --------------

local sniping_item = actions.get_sniping_item()

toast("Sniping " .. sniping_item)

actions.navigate_to_item_from_search(sniping_item)

while true do
    snipe_px_check(sniping_item)
end
