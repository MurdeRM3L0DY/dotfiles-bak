local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

local function dump_lua(store, name, outfile)

    local luafile = assert(io.open(outfile, "w"))
    luafile:write(string.format("local %s = {\n", name))
    for class, code_point in pairs(store) do
        luafile:write(string.format("  %s = \"%s\",\n", class, code_point))
    end
    luafile:write("}\n")
    luafile:write(string.format("return %s", name))
    luafile:close()
end

local function process_css(name, outfile, ...)

    local infiles = {...}


    local icon_class_regex = "%.([%a%d%-_]+):before[%c%s]+%{[%c%s]+content:[%c%s]+\"\\([%a%d]+)\";[%c%s]+%}"

    local store = {}

    for _, infile in ipairs(infiles) do
        local cssfile = assert(io.open(infile, "r"))
        local content = cssfile:read("a")

        for class, utf_8 in string.gmatch(content, icon_class_regex) do
            if class then
                store[class:gsub("%-", "_")] = utf8.char(tonumber(utf_8, 16))
            end
        end

        cssfile:close()
    end

    dump_lua(store, name, outfile)

end

local function process_local_css(name, ...)
    local outfile = script_path() .. string.format("/%s.lua", name)
    process_css(name, outfile, ...)
end

process_local_css("remixicon", script_path() .. "remixicon/remixicon.css")
process_local_css("nerdfont", script_path() .. "nerdfont/nerdfont.css")
process_local_css("weathericons", script_path() .. "weather-icons/css/weather-icons.css",
    script_path() .. "weather-icons/css/weather-icons-wind.css")
