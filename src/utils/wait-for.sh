# Wait for directory/file exists.
#
# 1: [d|f] d=Direcotry | f=File
# 2: {String} Directory/file path.
# 3: {Integer} (Optional | Default: 0) Time out. 0 to disable timeout.
# 4: {Boolean} (Optional | Default: true) Show message
# Return: 0 if file exists, 1 if file not exists (time-out).

local wait_type="$1"
local path="$2"
local timeout=$3
local show_message=$4

[ ! -z "${timeout}" ] && timeout=0
[ -z "${show_message}" ] && show_message=true

local p='...'
local count=0

while ( [ "${wait_type}" == 'd' ] && [ ! -d "${path}" ] ) || ( [ "${wait_type}" == 'f' ] && [ ! -f "${path}" ] )
  do
    if ${show_message}; then
      if [[ ${timeout} -gt 1 ]]; then
        if [[ ${timeout} -lt ${count} ]]; then
          # Time out!
          return 1
        else
          let count=count+1
        fi
      fi

      @echo-back "Waiting for '${path}'${p}"

      if [ "${p}" == '...' ]; then
        p='.'
      else
        p="${p}."
      fi
    fi

    sleep 1
  done

# Exists
return 0
