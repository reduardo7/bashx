file="$(@mktemp)"

echo foo >${file}
echo bar >>${file}
echo goo >>${file}

result="$(@file.contains 'bar' "${file}")"
@@assert.noOut "${result}"

@file.contains 'bar' "${file}"
@@assert.notErrorCode $?

@file.contains 'xx' "${file}"
@@assert.errorCode $?

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
