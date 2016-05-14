# Check if run as Root.
#
# Return: $TRUE if is root, $FALSE is not root.
if [ "`id -u`" -ne 0 ]; then
  # No Root
  return $FALSE
else
  # Root
  return $TRUE
fi
