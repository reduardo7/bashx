## *
## Print at screen.
##
## Params:
##   *: {String} Text to print.

local str="$*"
local line

[ -z "${__print_var_prefix__}" ] && __print_var_prefix__="$(@style default)${BX_APP_PRINT_PREFIX} "
[ -z "${__print_var_suffix__}" ] && __print_var_suffix__="${BASHX_KEY_ESC}[0m"

# \t -> \s*2
str="$(@str-replace "${str}" '\t' '  ')"

# Print
echo "${str}" | while IFS= read -r line ; do
  printf '%s\n' "${__print_var_prefix__}${line}${__print_var_suffix__}" >&3
done
