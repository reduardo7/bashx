##
## Check if run as Root.
##
## Return: 0 if is root, 1 is not root.

if [[ "$(id -u)" -ne 0 ]]; then
  # No Root
  return 1
fi

# Root
return 0
