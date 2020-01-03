## *
## Remove color codes (special characters).
##
## Params:
##   *: {String} Text.
##
## Out: {String} Text without format.

# http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed

local pr

$BX_OS_IS_MAC && pr='E' || pr='r'

sed -${pr} "s/${BX_KEY_ESC}\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" <<<"$@"
