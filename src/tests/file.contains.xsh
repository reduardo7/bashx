file="$(@mktemp)"
foo='foo123*@#$^<>/?`'
bar='-{/!ba~\%[")+='

echo "${foo}" >${file}
echo "${bar}" >>${file}

result="$(@file-contains "${foo}" "${file}")"
@@assert.noOut "${result}"

result="$(@file-contains "${bar}" "${file}")"
@@assert.noOut "${result}"

@file-contains "${foo}" "${file}"
@@assert.notErrorCode $?

@file-contains "${bar}" "${file}"
@@assert.notErrorCode $?

@file.contains 'xx' "${file}"
@@assert.errorCode $?
