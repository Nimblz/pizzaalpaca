-- this type of class extension thing is inspired by Roact's component class, check it out:
-- https://github.com/Roblox/roact/blob/master/src/Component.lua

local GameModule = {}
local gameModuleMetatable = {}

function gameModuleMetatable:__tostring()
    return self.name
end

function GameModule:extend(name)
    local newModule = {name = name, __gamemodule = true}

    for k,v in pairs(self) do
        if k ~= "extend" then -- modules shouldnt extend other modules that's evil please do not do that.
            newModule[k] = v
        end
    end

    setmetatable(newModule, gameModuleMetatable)

    return newModule
end

-- constructor, fired on instantiation, core will be nil.
function GameModule:create()
    return
end

-- This is where you setup this module and make it ready for other modules to interact with.
-- It is not safe to interact with other modules at this step, but you can create references to them
function GameModule:preInit()
    return
end

-- This is where you should do this module's work, setup the behavior
-- this module is responsible for.
-- it is safe to interact with other modules at this stage but their behaviors
-- may not yet be setup. If your module is contingent on another module being
-- finished setting up its behavior, do that in postInit.
function GameModule:init()
    return
end

-- This is where you should interact with other modules.
function GameModule:postInit()
    return
end

return GameModule