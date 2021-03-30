## <<
## Script minify.
##
## Input (read from /dev/stdin): File path.
## Out: {String} Minified script.

local minify=''
local line

while read line; do
  line="$(@str.trim "${line}")"
  minify="$(@str.trim "${minify}")"

  if [ ! -z "${line}" ] && ! [[ "${line}" == "#"* ]]; then
    if [ ! -z "${minify}" ] && \
       ! [[ "${line}" == ")" ]]
    then
      if [[ "${minify}" == *"{" ]] || \
         [[ "${minify}" == *"[" ]] || \
         [[ "${minify}" == *";do" ]] || \
         [[ "${minify}" == *" do" ]] || \
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

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
