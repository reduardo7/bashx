# Write to LOG to Console
#
# *: Text to log

printf "¬ %.23s | %s:%s > %s\n" $(date +%F.%T.%N) ${BASH_SOURCE[2]##*/} ${BASH_LINENO[1]} "${@}" >&3
