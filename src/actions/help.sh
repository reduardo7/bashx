## [-a]
## Print basic usage (this).
##
## Options:
##   -a|--all: Show hidden actions help.

eval "$(@options 'print_all:-a|--all')"

local prefix="${BX_SCRIPT_FILE_NAME}"
local line

@title 'Help & Usage'

# Main
@usage-main "${BX_SCRIPT_FULL_PATH}" "${prefix}"

# Actions
if [ -d "${BX_ACTIONS_PATH}" ]; then
  for f in "${BX_ACTIONS_PATH}"/*.sh ; do
    if [ -f "${f}" ]; then
      if ${print_all} || [[ "$(@file-name "${f}" true)" != _* ]]; then
        @usage "${f}" "${prefix}"
      fi
    fi
  done
fi

# Base Actions
for f in "${BASHX_ACTIONS_PATH}"/*.sh ; do
  if [ -f "${f}" ]; then
    if ${print_all} || [[ "$(@file-name "${f}" true)" != _* ]]; then
      @usage "${f}" "${prefix}"
    fi
  fi
done
