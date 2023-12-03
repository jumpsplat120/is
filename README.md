# Is
Returns whether a value is, or inherits from, a class or type.

Built initially for [LÖVE2D](https://love2d.org/), this helper function easily checks standard Lua types, LÖVE Objects, or [Classy](https://github.com/jumpsplat120/Classy) Objects. It may also unitentonally handle other classes, you mileage may vary.

### Usage
```lua
--Standard lua type
local a = 5

is(a, "number") -- true

--LÖVE type
local b = love.physics.newWorld(0, 9.12, false)

--LÖVE types are case sensitive
--They are userdata, and due to
--order of operations, so will
--also return true for "userdata"
is(b, "world")    -- false
is(b, "World")    -- true
is(b, "userdata") -- true

--Classy type
local c = Point(10, 20)

--Classy compares against the Class
--object directly, so name comparisons
--will always return false.
is(c, "Point") -- false
is(c, Point)   -- true

--Classy's is method checks inheritence.
is(c, Object) -- true

--If extended_types has been added to the
--project, then Classy types will NOT be
--read as a table. If extended_types is
--not part of the project, then it WILL
--be read as a table.

--With extended_types:
is(c, "table") -- false

--Without extended_types:
is(c, "table") -- true
```

In order, it checks the following;
* If the value's `type()` is one of the standard lua types, compare it to the passed class. Lua's standard types don't inherit, so this is equivalent to `type(value) == Class`
* If the value's `type()` is userdata, attempt to call the `.typeOf` method of the userdata. This is to compare against LÖVE types.
* Finally, attempt's to call the `.is` method of whatever's left. This will handle Classy classes. If using [extended_types](https://github.com/jumpsplat120/extended_types), then this function will work as expected, otherwise, Classy classes will read as tables and will pretty much always return `false`.