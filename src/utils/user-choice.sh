## message options [default]
## User choice.
##
## Params:
##   message: {String} Message.
##   options: {String} Options. Chars separated by a space.
##   default: {Char} Default value on non user input or invalid choice.
##            Optional. Default: "".
##
## Out: User selection or Default.
##
## Usage example:
##   @user-choice "Message..." "a b c" "b"

# Message
local message="$1"
# Options
local options=($2)
# Default result
local default="$3"

[ -z "$message" ] && @throw-invalid-param message
[ -z "$options" ] && @throw-invalid-param options

local result="$default"
local user_input

# Read
read -n 1 -p "$(@style default)${BX_APP_PRINT_PREFIX} ${message} [${options}]: " user_input >&3
echo >&3

# Validate input
user_input=$(@trim "${user_input}")
if [ ! -z "${user_input}" ]; then
  for option in ${options[@]}; do
    if [ "${option}" == "${user_input}" ]; then
      # Valid input
      result="${option}"
    fi
  done
fi

# Result
echo "${result}"
