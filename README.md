# PizzaAlpaca

PizzaAlpaca is a lightweight module loading framework designed to help you modularize portions of your game.

# Module Structure

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local TestModule = PizzaAlpaca.GameModule:extend("TestModule")

function TestModule:preInit()
    print("testmodule pre-initialized")
end

function TestModule:init()
    print("testmodule initialized")
end

function TestModule:postInit()
    print("testmodule post-initialized")
end

return TestModule
```

# Module Loading

PizzaAlpaca provides two ways to load modules: `registerModule` and `registerChildrenAsModules`. registerModule will register an already required module class, wheras registerChildrenAsModules will automatically require and register the module children of a root instance.