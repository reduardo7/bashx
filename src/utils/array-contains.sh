## source search_array
## Array contains an element?
##
## Params:
##   source:       {String} Element/String to search.
##   search_array: {Array} Array where search for.
## Return: 0 if contains the search string, 1 if not contains the search string.
##
## Usage example:
##   @array-contains "abc" "${array[@]}"

[ -z "$2" ] && return 1

local e
for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
return 1
