## <file> <regexp>
## `sed` command alias compatible between Mac & Linux.
##
## Params:
##   file:   {String} File to edit.
##   regexp: {String} sed expression (e.g. "s/foo/bar/g").

local file="$1"
local regexp="$2"

if ${BX_OS_IS_MAC}; then
  sed -i '' -e "${regexp}" "${file}"
else
  sed -i -e "${regexp}" "${file}"
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
