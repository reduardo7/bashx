## *
## Print at screen.
##
## Params:
##   *: {String} Text to print.

local str="$*"
local line

[ -z "${__print_var_prefix__}" ] && __print_var_prefix__="$(@style default)${APP_PRINT_PREFIX} "
[ -z "${__print_var_suffix__}" ] && __print_var_suffix__="${KEY_ESC}[0m"

# \t -> \s*4
str="$(@str-replace "${str}" '\t' '    ')"

# Print
echo -e "${str}" | while read line ; do
  echo -e "${__print_var_prefix__}${line}${__print_var_suffix__}" >&3
done
