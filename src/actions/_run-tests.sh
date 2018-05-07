## [*]
## Run tests.
##
## Params:
##   *: {String} (Optional) Tests names to execute separated by a space.
##      If not setted, all tests will be executed.

local tests_names_to_execute=($*)

let error_count=0
let count=0
local test_result
local line='###############################################################################'

###############################################################################
# Asserts

local __assertion_fail_path__="$(mktemp)"
local __finish_tests_path__="$(mktemp)"
local __assertion_exec_out_std__="$(mktemp)"
local __assertion_exec_out_err__="$(mktemp)"
local __assertion_exec_out_info__="$(mktemp)"

__rmAssertionFailFile__() {
  [ -f "${__assertion_fail_path__}" ] && rm -f "${__assertion_fail_path__}"
}
__rmAssertionFailFile__

__rmlastTestsFile__() {
  [ -f "${__finish_tests_path__}" ] && rm -f "${__finish_tests_path__}"
}
__rmlastTestsFile__

__assertFail__() {
  @alert "Assert Fail: $@"
  touch "${__assertion_fail_path__}" || @error "Can not wirte '${__assertion_fail_path__}' file!"
  exit 1
}

__testAssertFail__() {
  @print "    - Test:            [$1]"
  @print "    - Exit code:       $2"
  @print "    - Expected result: $3"
  @print "    - STD OUT:         [$(cat ${__assertion_exec_out_std__})]"
  @print "    - ERR OUT:         [$(cat ${__assertion_exec_out_err__})]"
  @print "    - INFO OUT:        [$(cat ${__assertion_exec_out_info__})]"
  __assertFail__ "$4"
}

@@assertFail() { # message
  __assertFail__ "${FUNCNAME[0]} [$@] ($(caller))"
}

@@assertTrue() { # var
  if ! [ "$1" = true ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertFalse() { # var
  if ! [ "$1" = false ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertEmpty() { # var
  if [ ! -z "$1" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertNotEmpty() { # var
  if [ -z "$1" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertNumber() { # var
  if [ -z "$1" ] || ! [[ "$1" =~ ^[0-9][0-9]*$ ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertErrorCode() { # code
  @@assertNumber "$1"
  if [[ "$1" -eq 0 ]] || [[ "$1" -gt 255 ]] ; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertNotErrorCode() { # code
  @@assertNumber "$1"
  if [[ "$1" -gt 0 ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@assertEqual() { # str_a str_b
  if ! [ "$1" = "$2" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

@@assertNotEqual() { # str_a str_b
  if [ "$1" = "$2" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

@@assertContains() { # str_base str_search
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$1" == *"$2"* ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

@@assertNotContains() { # str_base str_search
  if [ -z "$1" ] || [ -z "$2" ] || [[ "$1" == *"$2"* ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

@@assertStartWith() { # str_base str_search_start
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$1" == "$2"* ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

@@assertEndWith() { # str_base str_search_end
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$1" == *"$2" ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

@@assertStdOut() { # cmd
  local result="$( eval "$1" 2>/dev/null 3>/dev/null )"
  if [ -z "${result}" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

@@assertNoStdOut() { # cmd
  local result="$( eval "$1" 2>/dev/null 3>/dev/null )"
  if [ ! -z "${result}" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

@@assertErrOut() { # cmd
  local result="$( ( eval "$1" >/dev/null 3>/dev/null ) 2>&1 )"
  if [ -z "${result}" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

@@assertNoErrOut() { # cmd
  local result="$( ( eval "$1" >/dev/null 3>/dev/null ) 2>&1 )"
  if [ ! -z "${result}" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

@@assertNoOut() { # cmd
  local result="$( eval "$1" 2>&1 3>&1 )"
  if [ ! -z "${result}" ]; then
    __assertFail__ "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

@@assertExec() { # fn_name expected_exit [params]
  local assertFn="$1"
  local expected=$2
  local params="$3"

  rm -f ${__assertion_exec_out_std__}
  rm -f ${__assertion_exec_out_err__}
  rm -f ${__assertion_exec_out_info__}

  local cmd="${assertFn} ${params}"
  ( eval "${cmd}" >${__assertion_exec_out_std__} 2>${__assertion_exec_out_err__} 3>${__assertion_exec_out_info__} ; exit $? )
  local result=$?

  if [[ "${expected}" =~ ^[0-9][0-9]*$ ]]; then
    [[ ${result} -eq ${expected} ]] && __testAssertFail__ "$cmd" ${result} ${expected} "$(caller)"
  elif ${expected}; then
    [[ ${result} -ne 0 ]] && __testAssertFail__ "$cmd" ${result} ${expected} "$(caller)"
  else
    [[ ${result} -eq 0 ]] && __testAssertFail__ "$cmd" ${result} ${expected} "$(caller)"
  fi

  return 0
}

@@assertRegExp() { # reg_exp str
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$2" =~ $1 ]]; then
    __assertFail__ "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

@@lastTest() {
  @alert 'WARNING: Forced finish tests! {@@lastTest}'
  touch "${__finish_tests_path__}" || @error "Can not wirte '${__finish_tests_path__}' file!"
  return 0
}

###############################################################################
# Tests

if [ -d "${TESTS_PATH}" ]; then
  for f in ${TESTS_PATH}/* ; do
    if [ -f "${f}" ]; then
      local src_test_name="$(@file-name "${f}" true)"
      if [ -z "${tests_names_to_execute}" ] || @array-contains "${src_test_name}" "${tests_names_to_execute[@]}" ]]; then
        @print "$(@style color:yellow)Testing ${src_test_name}..."
        let count=count+1

        __rmAssertionFailFile__
        ( . "${f}" ; exit $? )
        test_result=$?

        if [[ ${test_result} -eq 0 ]]; then
            # Success
            @print "$(@style color:green)Success"
          else
            # Error
            let error_count=error_count+1
            if [ -f "${__assertion_fail_path__}" ]; then
              __rmAssertionFailFile__
            else
              @alert "Warning: No exit from assert"
            fi
            @alert "Fail! Exit code: ${test_result}"
          fi

        @print
        @print "${line}"
        @print

        [ -f "${__finish_tests_path__}" ] && break
      fi
    fi
  done
fi

###############################################################################
# Finish

__rmAssertionFailFile__
__rmlastTestsFile__

@print "Tests executed: ${count}"
@print

if [[ ${error_count} -eq 0 ]]; then
  @print 'All tests success!'
  exit 0
else
  @error "${error_count} tests fail!" false
fi
