# Check error.
#
# 1: {Integer} Exit code. Example: $?
# 2: {String} Command to execute on error.
# Example: @check_error $? "Invalid operation".
if @is_number "$1"; then
  if [ $1 -gt 0 ]; then
    # Error
    @error "$2" $1
  fi
fi
