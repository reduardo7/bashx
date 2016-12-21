file="$(mktemp)"

echo foo >${file}
echo bar >>${file}
echo goo >>${file}

result="$(@file-contains 'bar' "${file}")"
@@assertNoOut "${result}"

@file-contains 'bar' "${file}"
@@assertNotErrorCode $?

@file-contains 'xx' "${file}"
@@assertErrorCode $?
