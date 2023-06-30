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

return base