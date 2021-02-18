script='fnx() { local x="x" ; echo "${x}a${x}" ; } ; fnx'
output="$(@log.cmd "${script}" 3>/dev/null 2>/dev/null)"
@@assert.contains "${output}" 'xax'

output="$(var=123 ; fnx() { c="var=456 ; echo [${1}]" ; echo "$c" ; eval "$c" ; } ; @log.cmd fnx "\\\$var" 3>/dev/null 2>/dev/null)"
@@assert.contains "${output}" '[456]'
