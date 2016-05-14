# Check error.
#
# 1: {Integer} Exit code. Example: $?
# 2: {String} Command to execute on error.
# Example: @check-error $? "error 'Invalid operation'".

if @is-number "$1"; then
  if [ $1 -gt 0 ]; then
    # Error
    $2
  fi
fi
