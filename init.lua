local datatypes = {
    ["nil"]      = true,
    ["table"]    = true,
    ["thread"]   = true,
    ["number"]   = true,
    ["string"]   = true,
    ["boolean"]  = true,
    ["function"] = true,
    ["userdata"] = true
}

---Returns whether a value is, or inherits from, a class or type.
---Handles all standard types, as well as love types passed in as a string,
---and also handles [classic](https://github.com/rxi/classic) classes. May also
---unitentonally handle other classes. In order, it checks the following;
--- * If `type(value) == "userdata"` and `"T ~= "userdata"`, then attempt to
---call `value:typeOf(T)`.
---This is to compare against love types.
--- * If `type(value)` is one of the standard lua types, do a simple comparison.
--- * Finally, attempt's to call the `.is` method of whatever's left. This will
---handle *classic* classes.
---If using `extended_types`, then this function will work as expected,
---otherwise, classic classes will read as tables and will pretty much always
---return false.
---@param value any
---@param T string
---@return boolean
---@nodiscard
return function(value, T)
    local type = type(value)

    if type == "userdata" and T ~= "userdata" then
        return not not select(2, pcall(value.typeOf, value, T))
    end

    if datatypes[type] then
        return value == T
    end
    
    return not not select(2, pcall(value.is, value, T))
end