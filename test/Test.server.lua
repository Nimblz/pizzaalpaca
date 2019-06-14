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

local core = PizzaAlpaca.GameCore.new()

core:registerModule(TestModule)
core:registerModule("invalid")

core:load()