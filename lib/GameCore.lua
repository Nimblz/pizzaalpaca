local src = script.Parent

local compileSubmodules = require(src:WaitForChild("compileSubmodules"))
local callOnAll = require(src:WaitForChild("callOnAll"))

local GameCore = {}

local errors = {
    invalidArgument = "Invalid argument: [%s]. expected: [%s]."
}

local function instanceModule(class, core)
    return setmetatable({
        core = core
    },{__index = class, __tostring = getmetatable(class).__tostring})
end

function GameCore.new()
    local core = setmetatable({
        _moduleClasses = {},
        _modules = {},
    }, {__index = GameCore})

    return core
end

function GameCore:registerModule(moduleClass)
    local moduleClassType = typeof(moduleClass)

    if moduleClassType == "table" then
        assert(moduleClass.__gamemodule, 
            errors.invalidArgument:format(
                tostring(moduleClass),
                "GameModule class"
            ),
            2
        )
        self._moduleClasses[moduleClass.name] = moduleClass
    elseif moduleClassType == "Instance" then
        assert(moduleClass:IsA("ModuleScript"),
            errors.invalidArgument:format(
                moduleClass:GetFullName(),
                "ModuleScript"
            ),
            2
        )

        local requiredModuleClass = require(moduleClass)
        self:registerModule(requiredModuleClass) -- register the class
    else
        error(errors.invalidArgument:format(
            tostring(moduleClass),
            "GameModule class or ModuleScipt of GameModule class"),
            2
        )
    end
end

function GameCore:registerChildrenAsModules(root)
    for _, module in pairs(compileSubmodules(root,true)) do
        self:registerModule(module)
    end
end

function GameCore:instanceAllModules()
    -- instance modules
    for name, class in pairs(self._moduleClasses) do
        self._modules[name] = instanceModule(class, self)
    end
end

function GameCore:getModule(name)
    if not self._modules[name] then
        warn(("No such module %s"):format(tostring(name)))
    end
    return self._modules[name]
end

function GameCore:callOnModules(methodName)
    callOnAll(self._modules, methodName)
end

function GameCore:load()
    self:instanceAllModules()
    self:callOnModules("preInit")
    self:callOnModules("init")
    self:callOnModules("postInit")
end

return GameCore