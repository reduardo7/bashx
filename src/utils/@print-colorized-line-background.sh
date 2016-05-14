# Print gradiant line.
#
# 1: {Integer} [0-255] From color.
# 2: {Integer} [0-255] To color.
# 3: {Char} (Default: #) Character to print.
# Out: {String} Colorized line.

# Char
if [ $# -gt 2 ]; then
  local c="$3"
else
  local c="#"
fi

# Print
for i in {${1}..${2}} {${2}..${1}} ; do
  echo -en "`@style background:${i}`${c}"
done

# Default
@style default
