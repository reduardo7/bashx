## [create [type]]
## Create a temporary file or directory, safely, and print its name.
## It works like "mktemp", but the result is saved in ${BX_APP_TMP_PATH}.
## When the script finishes running, the ${BX_APP_TMP_PATH} directory is
## completely removed along with all its contents.
##
## Params:
##   create: {Boolean} Do not create anything; merely print a name.
##           Optional. Default: true.
##   type:   {Constant} Creta File or Directory.
##           Options:
##             f || file: Create file.
##             d || dir || directory: Create directory.
##           Optional. Default: "f".
##
## Out: Print its name.

local create="${1:-true}"
local type="${2:-f}"

local p="${BX_APP_TMP_PATH}$(env LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 10)XXXXXX"
local cmd="-q"

case "${type}" in
  f|file)
    # Default is "file", do nothing.
    ;;
  d|dir|directory)
    cmd="${cmd} -d"
    ;;
  *)
    # Default is "file", do nothing.
    ;;
esac

if ${create}; then
  cmd="${cmd} -u"
fi

eval "mktemp ${cmd} ${p} 2>/dev/null || mktemp ${cmd} -t ${p} 2>/dev/null"
