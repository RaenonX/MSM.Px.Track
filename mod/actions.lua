coordinates = require(scriptPath() .. "mod/coordinates")
configs = require(scriptPath() .. "mod/configs")
functions = require(scriptPath() .. "mod/functions")

local base = {}

function base.px_ocr(region)
    region:highlight()

    local px
    local success

    px, success = numberOCRNoFindException(region, "px-num-")
    region:highlightOff()

    if not success then
        return nil
    end

    return px
end

function base.upload_px(item, px)
    return functions.api_post(
        "/api/px", 
        {
            item = item,
            px = tostring(px)
        }
    )
end

function base.get_tracking_items()
    local tracking_items_str = functions.api_get("/api/item/tracking")

    tracking_items = { }
    index = 1

    for item in string.gmatch(tracking_items_str, "[^,]+") do 
        tracking_items[index] = item
        index = index + 1
    end

    return tracking_items
end

function base.click_search_bar_focus()
    functions.random_click(coordinates.location_search_bar_focus)
    functions.random_wait(configs.click_wait_sec)
end

function base.click_search_bar_clear()
    functions.random_click(coordinates.location_search_bar_clear)
    functions.random_wait(configs.click_wait_sec)
end

function base.click_search_execute() 
    functions.random_click(coordinates.location_search_bar_search)
    functions.random_wait(configs.click_wait_sec)
end

return base