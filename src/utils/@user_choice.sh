# User confirm.
#
# 1: {String} Message.
# 2: {Array} Options.
# 3: {Char} (Default: "") Default value on non user input or invalid choice.
# Result (User input) in $RESULT.

# Message
local m="$1"
# Options
local o=($2)
# Default
local d=""

if [ $# -gt 2 ]; then
  d="$3"
fi

# Read
read -n 1 -p "`@style default`${ECHO_CHAR} ${m} [${o}]: " i
echo
local RESULT="${d}"
i=`@trim "$i"`
if [ ! -z $i ]; then
  # Validate input
  for x in $o; do
    if [ "${x}" == "${i}" ]; then
      # Valid input
      RESULT="${x}"
    fi
  done
fi
