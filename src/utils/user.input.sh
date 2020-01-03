## [msg [default [max_len [timeout [silent]]]]]
## Request user info.
##
## Params:
##   msg:     {String} Message.
##            Default: "".
##   default: {String} Default value.
##            Default: "".
##   max_len: {Integer} Max length for input.
##            Default: "".
##   timeout: {Integer} Timeout.
##            Default: "".
##   silent:  {Boolean} Silent user output?
##            Default: false.
##
## Output: User input result.
## Return: 0 if valid user input;
##         1 if cancel;
##         2 if empty user input and returns default value.
##
## Usage example:
##   local txt="$(@user.input "Enter text:")"
##   local exitCode=$?

local msg="$1"
local default="$2"
local max_len="$3"
local timeout="$4"
local silent=${5:-false}

local cmd='read'

if [ ! -z "${max_len}" ] && @isNumber "${max_len}"; then
  cmd="${cmd} -n ${max_len}"
fi

if [ ! -z "${timeout}" ] && @isNumber "${timeout}"; then
  cmd="${cmd} -t ${timeout}"
fi

if ${silent}; then
  cmd="${cmd} -s"
fi

# Execute
local i
${cmd} -p "$(@style default)${BASHX_APP_PRINT_PREFIX} ${msg}$(@style system)" i >&3
local r=$?
local rta=0

echo >&3

if [ "${i}" == "${BX_KEY_ESC}" ]; then
  rta=1
  i="${default}"
else
  # 142 == No user input
  if [ "${r}" == '142' ] || [ -z "${i}" ]; then
    # Default value
    rta=2
    i="${default}"
  fi
fi

# Result
echo "${i}"
return ${rta}
