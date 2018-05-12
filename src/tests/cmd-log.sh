script='fnx() { local x="x" ; echo "${x}a${x}" ; } ; fnx'
output="$(@cmd-log "${script}" 3>/dev/null 2>/dev/null)"
@@assert.contains "${output}" 'xax'

output="$(var=123 ; fnx() { c="var=456 ; echo [${1}]" ; echo "$c" ; eval "$c" ; } ; @cmd-log fnx "\\\$var" 3>/dev/null 2>/dev/null)"
@@assert.contains "${output}" '[456]'
