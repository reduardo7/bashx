# User confirm.
#
# 1: {String} (Optional) Message.
# 2: {Array} (Default: ( "y" )) Valid options. Case insensitive.
# 3: {Integer} (Default: $TRUE) Default result on non user input. $TRUE to confirm, $FALSE to no confirm.
# Return: $TRUE if user confirm, $FALSE if user not confirm.

# Message
local m="Confirm? [Y = Yes | N = No]"
if [ $# -gt 0 ]; then
  m="$1"
fi

# Options
local o=( "y" )
if [ $# -gt 1 ]; then
  o=($2)
fi

# Default
local d=$FALSE
if [ $# -gt 2 ]; then
  if [ ${3} == $TRUE ]; then
    d=$TRUE
  else
    d=$FALSE
  fi
fi

# Read
local i=""
read -n 1 -p "`@style default`${ECHO_CHAR} ${m}: " i
echo
i=$(@trim "$i")
if [ -z "$i" ]; then
  # Default
  return $d
else
  # Validate input
  for x in $o; do
    if [ "`@str_to_lower "${x}"`" == "`@str_to_lower "${i}"`" ]; then
      # User accept
      return $TRUE
    fi
  done
fi

return 1
