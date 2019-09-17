# PizzaAlpaca

PizzaAlpaca is a lightweight module loading framework designed to help you modularize portions of your game.

# How to create a core

```lua
print("Starting client.")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- define some paths
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = script.Parent

-- define our module directories
local sidedModules = client:WaitForChild("gameModules")
local commonModules = common:WaitForChild("gameModules")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

-- create PizzaAlpaca core instance
local clientCore = PizzaAlpaca.GameCore.new()
-- clientCore._debugPrints = true -- debug prints allow you to see what PizzaAlpaca is doing in the output

-- load sided and common modules
clientCore:registerChildrenAsModules(commonModules)
clientCore:registerChildrenAsModules(sidedModules)

-- start the core
clientCore:load()

print("Loading complete! Thanks for playing!~")

```

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