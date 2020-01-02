## *
## Print at screen.
##
## Params:
##   *: {String} Text to print.

local str="$@"
local line

[ -z "${__print_var_prefix__}" ] && __print_var_prefix__="$(@style default)${BX_APP_PRINT_PREFIX} "

# \t -> \s*2
str="$(@str.replace "${str}" '\t' '  ')"

# Print
echo -e "${str}" | while IFS= read -r line ; do
  echo -e "${__print_var_prefix__}${line}${BASHX_KEY_ESC}[0m" >&3
done