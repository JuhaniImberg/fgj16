local helpers = {}

function helpers.bind(t, k)
    return function(...) return t[k](t, ...) end
end

return helpers
