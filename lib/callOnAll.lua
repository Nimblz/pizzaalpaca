return function(table, methodname, args, callback)
    for k, v in pairs(table) do
        callback(k,v)
        v[methodname](v, unpack(args))
    end
end