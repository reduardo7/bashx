# Write to LOG to Console
#
# *: Text to log
printf "LOG> %.23s | %s[%s]: %s\n" `date +%F.%T.%N` ${BASH_SOURCE[1]##*/} ${BASH_LINENO[0]} "${@}"
