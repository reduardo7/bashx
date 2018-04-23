## <<
## Script minify.
##
## Out: {String} Minified script.

local minify=''
local line

while read line; do
  line="$(@trim "${line}")"
  minify="$(@trim "${minify}")"

  if [ ! -z "${line}" ] && ! [[ "${line}" == "#"* ]]; then
    if [ ! -z "${minify}" ] && \
       ! [[ "${line}" == ")" ]]
    then
      if [[ "${minify}" == *"{" ]] || \
         [[ "${minify}" == *";then" ]] || \
         [[ "${minify}" == *" then" ]] || \
         [[ "${minify}" == *";else" ]] || \
         [[ "${minify}" == *" else" ]] || \
         [[ "${minify}" == *"(" ]]
      then
        minify="${minify} " # space
      else
        minify="${minify};"
      fi
    fi
    minify="${minify}${line}"
  fi
done < /dev/stdin

echo "${minify}"
