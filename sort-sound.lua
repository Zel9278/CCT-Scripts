local spk = peripheral.find("speaker")
if spk == nil then
    error("no such speaker(top)")
end

local args = {...}

if args[1] == nil or tonumber(args[1]) == nil  then
    error("no args, this args is number!")
end

local max = tonumber(args[1])
local arr = {}

print("generate random sort")

function shuffle(t)
    local s = {}
    for i = 1, #t do 
        s[i] = t[i]
    end

    for i = #t, 2, -1 do
        local j = math.random(i)
        s[i], s[j] = s[j], s[i]
        spk.playNote("bit", 1, s[i]*24/max)
        sleep(0.02)
    end
    return s
end

function main(data, n)
    for i = 1, n do
        data[0] = 0;
        if data[i-1] > data[i] then
            j = i
            tmp = data[i]
            while j > 0 and data[j-1] > tmp do
                data[j] = data[j-1]
                j = j-1
                sleep(0.05)
                spk.playNote("bell", 1, data[j]*24/n)
            end
            data[j] = tmp
        end

        if i >= n then
            for k, v in ipairs(data) do
                spk.playNote("bit", 1, data[v]*24/n)
                sleep(0.05)
            end
            print("sort done")
        end
    end
end

for i = 1, max do
    arr[i] = i

    if i == max then
        print("generated " .. max .. " objects")
        print("shuffle objects")
        local data = shuffle(arr)

        sleep(1)
        print("start sorting")
        main(data, max)
    end 
end
