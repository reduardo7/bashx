## *
## Write to LOG to Console.
##
## *: {String} Text to log.

printf "¬ %.23s | %s:%s > %s\n" $(date +%F.%T.%N) ${BASH_SOURCE[2]##*/} ${BASH_LINENO[1]} "${@}" >&3

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
