# Wait for directory exists.
#
# 1: {String} Directory path.
# 2: {Integer} (Optional) Time out.
# Return: 0 if file exists, 1 if file not exists (time-out).

local p="..."
local COUNT=0
while [ ! -d "$1" ] ; do
  if [ $# -gt 1 ]; then
    if [ $2 -gt $COUNT ]; then
      # Time out!
      return 1
    else
      let COUNT=COUNT+1
    fi
  fi
  @echo_back "Waiting for '${1}'${p}"
  sleep 1
  if [ "${p}" == "..." ]; then
    p="."
  else
    p="${p}."
  fi
done
# Exists
return 0
