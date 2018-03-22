##
## Generate random string.
##
## Out: {String} Random string.

env LC_ALL=C tr -dc "a-zA-Z0-9" < /dev/urandom | head -c 10
