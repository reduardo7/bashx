## type path [timeout [show_message]]
## Wait for directory/file until exists.
##
## Params:
##   type:         {char} [d|f] d=Direcotry | f=File
##   path:         {String} Directory/file path.
##   timeout:      {Integer} Timeout. 0 to disable timeout.
##                 Optional. Default: 0.
##   show_message: {Boolean} Show message.
##                 Optional. Default: true.
##
## Return: 0 if file exists, 1 if file not exists after timeout.

local type="$1"
local path="$2"
local timeout=${3:-0}
local show_message=${4:-true}

local cmd
local msg

case "${type}" in
  d|D) cmd="[ -d '${path}' ]" ;;
  f|F) cmd="[ -f '${path}' ]" ;;
  *) @throw-invalid-param type
fi

if ! ${show_message}; then
  msg='false'
fi

@wait-until "${cmd}" 1 ${timeout} "${msg}"
return $?
