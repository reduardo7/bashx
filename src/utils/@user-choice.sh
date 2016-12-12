# User choice.
#
# 1: {String} Message.
# 2: {String} Options. Chars separated by a space.
# 3: {Char} (Default: "") Default value on non user input or invalid choice.
# Out: User selection or Default.
#
# Example:
#   @user-choice "Message..." "a b c" "b"

# Message
local message="$1"
# Options
local options=("$2")
# Default result
local result="$3"

local user_input

# Read
read -n 1 -p "$(@style default)${ECHO_CHAR} ${message} [${options}]: " user_input >&2
echo >&2

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
