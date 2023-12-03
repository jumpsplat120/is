---Returns whether a value is, or inherits from, a class or type.
---Handles all standard types, as well as love types passed in as a string,
---and also handles classic Classes. May also unitentonally handle other classes,
---but makes no promises. In order, it checks the following;
--- * If the value's `type()` is one of the standard lua types, compare it to the passed class. Lua's standard types don't inherit, so this is equivalent to `type(value) == Class`
--- * If the value's `type()` is userdata, attempt to call the `.typeOf` method of the user This is to compare against love types.
--- * Finally, attempt's to call the `.is` method of whatever's left. This will handle classic classes.
---If using `extended_types`, then this function will work as expected, otherwise,
---classic classes will read as tables and will pretty much always return false.
---@param value any The value to check.
---@param Class string|Class Either a string denoting the type, or the class itself.
---@return boolean #Values returned from `.is` will be cast to a boolean, even if it's been overridden.
return function(value, Class)
    local t = type(value)

    if t == "boolean"  or
       t =="nil"       or
       t =="number"    or
       t == "string"   or
       t == "function" or
       t == "table"    or
       t == "thread"  then return t == Class end
    if t == "userdata" then return not not select(2, pcall(value.typeOf, value, Class)) end
    
    return not not select(2, pcall(value.is, value, Class))
end