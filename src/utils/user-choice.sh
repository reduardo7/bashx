## msg options [default]
## User choice.
##
## msg:     {String} Message.
## options: {String} Options. Chars separated by a space.
## default: {Char} (Default: "") Default value on non user input or invalid choice.
## Out:     User selection or Default.
##
## Usage example:
##   @user-choice "Message..." "a b c" "b"

# Message
local message="$1"
# Options
local options=("$2")
# Default result
local result="$3"

local user_input

# Read
read -n 1 -p "$(@style default)${ECHO_CHAR} ${message} [${options}]: " user_input >&3
echo >&3

# Validate input
user_input=$(@trim "$user_input")
if [ ! -z "$user_input" ]; then
  for x in ${options[@]}; do
    if [ "$x" == "$user_input" ]; then
      # Valid input
      result="$x"
    fi
  done
fi

# Result
echo $result
