configs = require(scriptPath() .. "mod/configs")

local base = {}

-- Create randomness + warm up
math.randomseed(os.time())
math.random()
math.random()
math.random()

local function generate_random(num, offset)
    return math.random(num - offset, num + offset)
end

local function table_merge(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
end

function base.random_wait(sec)
    local offset = configs.random_wait_sec_offset

    wait(generate_random(sec, offset))
end

function base.random_click(location)
    local offset = configs.random_click_px_offset

    click(Location(
        generate_random(location:getX(), offset),
        generate_random(location:getY(), offset)
    ))
end

function base.api_post(api_path, params)
    params.token = configs.api_token

    return httpPost("https://msm-api.raenonx.cc" .. api_path, params)
end

function base.api_get(api_path)
    return httpGet("https://msm-api.raenonx.cc" .. api_path)
end

function base.get_current_timestamp_str()
    time = os.date("*t")
    return ("%04d%02d%02d-%02d%02d%02d"):format(
        time.year,
        time.month,
        time.day,
        time.hour, 
        time.min, 
        time.sec
    )
end

return base
