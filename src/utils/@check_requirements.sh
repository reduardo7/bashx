# Check if all parameters are installed.
#
# *: {String} Command to check.

for req in $@ ; do
  if ! hash "$req" 2>&- ; then
    @error "Please install '${req}' to continue."
  fi
done
