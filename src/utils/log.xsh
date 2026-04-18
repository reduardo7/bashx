## *
## Print at screen.
##
## Params:
##   *: {String} Text to print.

local str="$@"
local line

[ ! -z "${__print_var_prefix__}" ] || __print_var_prefix__="$(@style)${BASHX_APP_PRINT_PREFIX} "

# \t -> \s*2
str="$(@str.replace "${str}" '\t' '  ')"

local _reset=''
${BASHX_APP_COLORS_ENABLED} && _reset="${BX_KEY_ESC}[0m"

# Print
echo -e "${str}" | while IFS= read -r line ; do
  echo -e "${__print_var_prefix__}${line}${_reset}" >&3
done

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
