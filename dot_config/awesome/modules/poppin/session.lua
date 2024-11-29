local session = {}

-- Serialize a lua table into a string.
local function serialize(t)
    -- helper function
    local function serialize_value(v)
        if type(v) == "table" then
            return serialize(v)
        elseif type(v) == "string" then
            return string.format("%q", v)
        else
            return tostring(v)
        end
    end

    local s = {}

    for k, v in pairs(t) do
        s[#s + 1] = "["
            .. serialize_value(k)
            .. "]="
            .. serialize_value(v)
            .. ","
    end
    return "{" .. table.concat(s) .. "}"
end

local function deserialize(s)
    return load("return " .. s)()
end

local function init()
    awesome.register_xproperty("poppin.name", "string")
    awesome.register_xproperty("poppin.command", "string")
    awesome.register_xproperty("poppin.properties", "string")
end

session.save = function(name, app)
    local c = app.client
    c:set_xproperty("poppin.name", name)
    c:set_xproperty("poppin.command", app.command)
    c:set_xproperty("poppin.properties", serialize(app.properties))
end

session.restore = function()
    local apps = {}
    local clients = client.get()
    for _, c in pairs(clients) do
        if session.isPoppin(c) then
            apps[c:get_xproperty("poppin.name")] = {
                command = c:get_xproperty("poppin.command"),
                properties = deserialize(c:get_xproperty("poppin.properties")),
                client = c,
            }
        end
    end

    return apps
end

-- Check whether a client is being managed by poppin.
session.isPoppin = function(c)
    local name_xprop = c:get_xproperty("poppin.name")
    return name_xprop and #name_xprop > 0
end

init()

return session
