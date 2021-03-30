## *
## Clean variable name.
## Replace all non valid character by "_".
##
## Params:
##   *: {String} String to clean.
##
## Out: {String} Valid variable name.

echo "${*//[^a-zA-Z0-9]/_}"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
