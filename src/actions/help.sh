## [options]
## Print basic usage (this).
##
## Params:
##   options: {Constant} Options.
##            Values:
##              all: Print hidden actions too.
##            Optional.

local options="$1"
local prefix="${SCRIPT_FILE_NAME} "
local line
local print_all=false

case "${options}" in
  all)
    print_all=true
    ;;
esac

@title 'Help & Usage'

# Main
@usage-main "${SCRIPT_FULL_PATH}" "${prefix}"

# Actions
if [ -d "${ACTIONS_PATH}" ]; then
  for f in ${ACTIONS_PATH}/*.sh ; do
    if [ -f "${f}" ]; then
      if ${print_all} || [[ "$(@file-name "${f}" true)" != _* ]]; then
        @usage "${f}" "${prefix}"
      fi
    fi
  done
fi

# Base Actions
for f in ${BASHX_ACTIONS_PATH}/*.sh ; do
  if [ -f "${f}" ]; then
    if ${print_all} || [[ "$(@file-name "${f}" true)" != _* ]]; then
      @usage "${f}" "${prefix}"
    fi
  fi
done
