return function(table, methodname, ...)
    for _, v in pairs(table) do
        v[methodname](v, ...)
    end
end