local base = {}

base.click_wait_sec = 0.65
base.type_wait_sec = 0.75

base.random_wait_sec_offset = 0.1
base.random_click_px_offset = 10

base.api_token = "P1xellily1sAB1ja55!"

function base.initialize()
    Settings:set("MinSimilarity", 0.8)
    -- Created on 2960 x 1440 (Note 8)
    Settings:setScriptDimension(true, 2960)
    Settings:setCompareDimension(true, 2960)
    
    setImmersiveMode(true)
    autoGameArea(true)
end

return base