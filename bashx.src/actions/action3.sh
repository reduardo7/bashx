## p1
## Test 3.

local p1="$1"
[ "$p1" != '123' ] && @throw-invalid-param p1

@print Action 3
@print p1: $1
