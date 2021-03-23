## [len]
## Generate random string.
##
## Out: {String} Random string.

local len="${1:-10}"

local p="$(env LC_ALL=C tr -dc "a-zA-Z0-9" < /dev/urandom 2>/dev/null | head -c ${len})"

if [[ -z "${p}" ]]; then
  shuf -zer -n${len} {A..Z} {a..z} {0..9} 2>/dev/null
else
  echo "${p}"
fi
