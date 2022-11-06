local mo = peripheral.wrap("left")
if mo == nil then
    error("no such monitor")
end

mo.setBackgroundColor(colors.black)

local binaryList = {
    [0] = {0, 0, 0, 0},
    [1] = {0, 0, 0, 1},
    [2] = {0, 0, 1, 0},
    [3] = {0, 0, 1, 1},
    [4] = {0, 1, 0, 0},
    [5] = {0, 1, 0, 1},
    [6] = {0, 1, 1, 0},
    [7] = {0, 1, 1, 1},
    [8] = {1, 0, 0, 0},
    [9] = {1, 0, 0, 1} 
}

local margin = 5

function split(str)
    t = {}
    for i = 1, string.len(str) do
        t[i] = tonumber(string.sub(str, i,i))
    end
    return t
end

function toBinary(val)
    local b = binaryList[val]
    return b
end

function binaryRenderer(hour, min, sec)
    local margeTime = hour .. min .. sec
    local splitTime = split(margeTime, "")
     
    for k, v in ipairs(splitTime) do
        
        local b = toBinary(v)
        for kk, vv in ipairs(b) do
            if k <= 2 then
                mo.setCursorPos(k+margin, kk)
            elseif k <= 4 then
                mo.setCursorPos(k+margin+1, kk)
            else
                mo.setCursorPos(k+margin+2, kk)
            end
            
            if vv == 1.0 then
                mo.blit(" ", "f", "0")
            else
                mo.blit(" ", "f", "7")
            end
        end
    end
end

function main()
    local time = os.epoch("local", true) / 1000
    local nowHour = os.date("%H", time)
    local nowMin = os.date("%M", time)
    local nowSec = os.date("%S", time)

    mo.clear()
    binaryRenderer(nowHour, nowMin, nowSec)
    mo.setTextColor(colors.white)

    mo.setCursorPos(margin+1,5)
    mo.write(nowHour .. ":" .. nowMin .. ":" .. nowSec)

    mo.setCursorPos(1,1)
    mo.write("8")
    mo.setCursorPos(1,2)
    mo.write("4")
    mo.setCursorPos(1,3)
    mo.write("2")
    mo.setCursorPos(1,4)
    mo.write("1")

    mo.setCursorPos(18,1)
    mo.write("r")
    mo.setCursorPos(18,2)
    mo.write("e")
    mo.setCursorPos(18,3)
    mo.write("a")
    mo.setCursorPos(18,4)
    mo.write("l")
end

while true do    
    main()
    sleep(0.1)
end

