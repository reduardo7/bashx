## [len]
## Generate random string.
##
## Out: {String} Random string.

local len="${1:-10}"

env LC_ALL=C tr -dc "a-zA-Z0-9" < /dev/urandom | head -c ${len}
