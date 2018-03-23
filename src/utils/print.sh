## *
## Print at screen.
##
## *: {String} Text to print.

local str="$*"

# \t -> \s*4
echo -e "$(@style default)${APP_PRINT_PREFIX} $(@str-replace "${str}" '\t' '    ')$(@style reset)" >&3
