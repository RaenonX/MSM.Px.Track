configs = require(scriptPath() .. "mod/configs")

local base = {}

-- Create randomness + warm up
math.randomseed(os.time())
math.random()
math.random()
math.random()

function generate_random(num, offset)
    return math.random(num - offset, num + offset)
end

function table_merge(t1, t2)
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

    return httpPost("https://msm.raenonx.cc" .. api_path, params)
end

return base
