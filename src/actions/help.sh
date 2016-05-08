##
## Alias of "usage", using less.

@check_requirements less
${_ACTION_PREFIX}usage "$@" | less -r

# Clear output
clear
