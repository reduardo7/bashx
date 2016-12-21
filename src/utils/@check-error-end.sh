# Check error.
#
# 1: {Integer} Exit code. Example: $?
# 2: {String} (Optional) Command to execute on error.
# Example: @check-error $? "Invalid operation".

local code=$1
local cmd="$2"

if @is-number "${code}"; then
  if [ ${code} -gt 0 ]; then
    # Error
    [ ! -z "${cmd}" ] && eval "${cmd}"
    @error '' ${code}
  fi
else
  # Error
  [ ! -z "${cmd}" ] && eval "${cmd}"
  @error '' ${code}
fi
