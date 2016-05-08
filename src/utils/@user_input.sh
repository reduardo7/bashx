# Request user info.
#
# 1: {String} (Default: "") Message.
# 2: {String} (Default: "") Default value.
# 3: {Integer} (Default: "") Max length for input.
# 4: {Integer} (Default: "") Timeout.
# 5: {Boolean} (Default: $FALSE) Silent user output?
# Result in $RESULT.
# Return: 0 if valid user input, 1 if cancel, 2 if empty user input and returns default value.

# 1: Message
local m=""
if [ $# -gt 0 ]; then
  m="${1}"
fi
# 2: Default Value
local d=""
if [ $# -gt 1 ]; then
  d="${2}"
fi
# 3: Max length
local n=""
if [ $# -gt 2 ] && @is_number "${3}"; then
  n=" -n ${3}"
fi
# 4: Timeout
local t=""
if [ $# -gt 3 ] && @is_number "${4}"; then
  t=" -t ${4}"
fi
# 5: Silent outut
local s=""
if [ $# -gt 4 ] && [ ${5} == $TRUE ]; then
  s=" -s"
fi
# Execute
local cmd="read${n}${s}${t}"
${cmd} -p "`@style default`${ECHO_CHAR} ${m}" i
echo
local r=$?
local rta=0
if [ "${i}" == "$KEY_ESC" ]; then
  rta=1
  i="${d}"
else
  # 142 == No user input
  if [ "${r}" == "142" ] || [ -z "${i}" ]; then
    # Default value
    rta=2
    i="${d}"
  fi
fi
# Result
RESULT="${i}"
return ${rta}
