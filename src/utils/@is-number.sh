# Check if is a number.
#
# 1: Required. Variable to check if is a number.
# Return: $TRUE if variable is a number, $FALSE if variable is not a number.
if [[ "$1" =~ ^[0-9]+$ ]]; then
  return $TRUE
else
  return $FALSE
fi
