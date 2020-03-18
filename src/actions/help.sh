## [-a]
## Print basic usage (this).
##
## Options:
##   -a|--all: Show hidden actions help.

eval "$(@args 'print_all:-a|--all')"

local prefix="${BX_SCRIPT_FILE_NAME}"
local line

@log.title 'Help & Usage'

# Main
@usage.file "${BX_SCRIPT_FULL_PATH}" "${prefix}"

# Actions
if [ -d "${BASHX_ACTIONS_PATH}" ]; then
  for f in "${BASHX_ACTIONS_PATH}"/*.sh ; do
    if [ -f "${f}" ]; then
      if ${args_print_all} || [[ "$(@file.name "${f}" true)" != _* ]]; then
        @usage "${f}" "${prefix}"
      fi
    fi
  done
fi

# Base Actions
for f in "${BASHX_ACTIONS_PATH}"/*.sh ; do
  if [ -f "${f}" ]; then
    if ${args_print_all} || [[ "$(@file.name "${f}" true)" != _* ]]; then
      @usage "${f}" "${prefix}"
    fi
  fi
done
