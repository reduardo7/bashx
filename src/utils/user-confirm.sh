## [msg [options [default]]]
## User confirm.
##
## msg:     {String} (Optional) Message.
## options: {Array} (Default: ( "y" )) Valid options. Case insensitive.
## default: {Boolean} (Default: false) Default result on non user input.
##          true to confirm, false to no confirm.
## Return:  0 if user confirm, 1 if user not confirm.

local m="$1"
local o=( $2 )
local d=$3

[ -z "${m}" ] && m='Confirm? [Y = Yes | N = No]'
[ -z "${o}" ] && o=( 'y' )

if [ -z "${d}" ]; then
  d=1
else
  ${d} && d=0 || d=1
fi

# Read
local i=''
read -n 1 -s -p "$(@style default)${APP_PRINT_PREFIX} ${m}: " i >&3
echo >&3

i="$(@trim "${i}")"

if [ -z "${i}" ]; then
  return ${d}
else
  # Validate input
  for x in $o; do
    if [ "$(@str-to-lower "${x}")" == "$(@str-to-lower "${i}")" ]; then
      # User accept
      return 0
    fi
  done
fi

return 1