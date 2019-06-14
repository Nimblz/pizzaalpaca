local errors = {
    IllegalArgument = "Argument 1 must be an instance, got %s",
}

return function(root, recurseThroughFolders)
    assert(root, errors.IllegalArgument:format(typeof(root)))
    assert(typeof(root) == "Instance", errors.IllegalArgument:format(typeof(root)))

    local modules = {}

    local function compileSubmodules(instance)
        for _, child in pairs(instance:GetChildren()) do
            if child:IsA("ModuleScript") then
                local requiredModule = require(child)

                modules[child] = requiredModule
            elseif child:IsA("Folder") and recurseThroughFolders then
                compileSubmodules(child)
            end
        end
    end

    compileSubmodules(root)

    return modules
end