## [action]
## Alias of "usage", using less.
##
## Params:
##   action: Action Name. Display action usage.

@check_requirements less
${_ACTION_PREFIX}usage "$@" | less -r

# Clear output
clear
