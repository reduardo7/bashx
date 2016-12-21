# Print gradiant line.
#
# 1: {Integer} [0-255] From color.
# 2: {Integer} [0-255] To color.
# 3: {Char} (Default: #) Character to print.
# Out: {String} Colorized line.

local color_from=$1
local color_to=$2
local chr="$3"

[ -z "${chr}" ] && chr='#'

# Print
for i in {${color_from}..${color_to}} {${color_to}..${color_from}} ; do
  echo -en "$(@style background:${i})${chr}" >&3
done
