coordinates = require(scriptPath() .. "mod/coordinates")
configs = require(scriptPath() .. "mod/configs")
functions = require(scriptPath() .. "mod/functions")
images = require(scriptPath() .. "mod/images")

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

function base.upload_loop_sec(item_count, loop_sec)
    return functions.api_post(
        "/api/script/loop", 
        { 
            count = tostring(item_count),
            elapsed = tostring(loop_sec)
        }
    )
end

function base.get_tracking_items()
    local tracking_items_str = functions.api_get("/api/item/tracking")

    local tracking_items = { }
    -- Can't start with 0, or the 1st item will be skipped
    local count = 1

    for item in string.gmatch(tracking_items_str, "[^,]+") do 
        tracking_items[count] = item
        count = count + 1
    end

    return count - 1, tracking_items
end

function base.get_sniping_item()
    local sniping_item = functions.api_get("/api/item/sniping-script")    

    if sniping_item == "" or sniping_item == nil then
        scriptExit("Sniping mode not activated! Activate it on the bot first.")
    end

    return sniping_item
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

function base.snipe_px_refresh()
    functions.random_click(coordinates.location_refresh)
    -- No waiting here since the OCR step later already gives some kind of delay
end

function base.navigate_to_item_from_search(item_name)
    -- Click on search bar (in search page)
    base.click_search_bar_focus()

    -- > Note that `type()` touches clipboard, 
    -- > so it's best that this script doesn't run on emulator
    -- Type item name
    type(item_name)
    functions.random_wait(configs.type_wait_sec)

    -- Click on search
    -- > Need to click twice, because the 1st clicks off text input
    -- > 2nd executes the search
    base.click_search_execute()
    base.click_search_execute()
end

function base.take_screenshot(folder_name)
	setImagePath(scriptPath() .. "image/" .. folder_name)

    local screen = getRealScreenSize()
    local screen_region = Region(0, 0, screen:getX(), screen:getY())
    
    screen_region:saveColor(functions.get_current_timestamp_str() .. ".png")
    
	setImagePath(scriptPath() .. "image")
end

function base.calibrate_init_screen()
    if functions.find_image(images.game_exit_confirm) then
        functions.random_click(coordinates.game_confirm_exit_no)
        functions.random_wait(configs.click_wait_sec)
    end

    if not functions.find_image(images.ts_quick_menu) then
        -- Not starting from main playing screen
        return
    end

    functions.random_click(coordinates.ts_quick_menu_btn)
    functions.random_wait(configs.click_wait_sec)

    functions.find_till_found_then_click(images.ts_buy_filter_btn, coordinates.ts_search_on_navbar)
end

return base