##
## Load asserts functions.
##

# Single load
[ ! -z "${__ASSERTION_LOADED__}" ] && return 0
__ASSERTION_LOADED__=true

ASSERTION_EXEC_OUT_STD="$(@mktemp false)"
ASSERTION_EXEC_OUT_ERR="$(@mktemp false)"
ASSERTION_EXEC_OUT_INF="$(@mktemp false)"

@@assert._assertFail() { # INTERNAL
  @log.alert "Assert Fail: $@"
  exit 1
}

@@assert._testAssertFail() { # INTERNAL
  @log "    - Test:            [$1]"
  @log "    - Exit code:       $2"
  @log "    - Expected result: $3"
  @log "    - STD OUT:         [$([ -f "${ASSERTION_EXEC_OUT_STD}" ] && cat "${ASSERTION_EXEC_OUT_STD}")]"
  @log "    - ERR OUT:         [$([ -f "${ASSERTION_EXEC_OUT_ERR}" ] && cat "${ASSERTION_EXEC_OUT_ERR}")]"
  @log "    - INFO OUT:        [$([ -f "${ASSERTION_EXEC_OUT_INF}" ] && cat "${ASSERTION_EXEC_OUT_INF}")]"
  @@assert._assertFail "$4"
}

##   @@assert.fail message
##     Test fail.
##     Params:
##       message: Message about the fail.
@@assert.fail() { # message
  @@assert._assertFail "${FUNCNAME[0]} [$@] ($(caller))"
}

##   @@assert.true var
##     Test if {var} is boolean true.
##     Params:
##       var: Variable to test.
@@assert.true() { # var
  if ! [ "$1" = true ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.false var
##     Test if {var} is boolean false.
##     Params:
##       var: Variable to test.
@@assert.false() { # var
  if ! [ "$1" = false ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.empty var
##     Test if {var} is empty.
##     Params:
##       var: Variable to test.
@@assert.empty() { # var
  if [ ! -z "$1" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.notEmpty var
##     Test if {var} is not empty.
##     Params:
##       var: Variable to test.
@@assert.notEmpty() { # var
  if [ -z "$1" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.number var
##     Test if {var} is a number.
##     Params:
##       var: Variable to test.
@@assert.number() { # var
  if [ -z "$1" ] || ! [[ "$1" =~ ^[0-9][0-9]*$ ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.errorCode code
##     Test if exit code is an error code.
##     Params:
##       code: Variable to test.
@@assert.errorCode() { # code
  @@assert.number "$1"
  if [[ "$1" -eq 0 ]] || [[ "$1" -gt 255 ]] ; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.notErrorCode code
##     Test if exit code is not an error code.
##     Params:
##       code: Variable to test.
@@assert.notErrorCode() { # code
  @@assert.number "$1"
  if [[ "$1" -gt 0 ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}

##   @@assert.equal str_a str_b
##     Test if {str_a} is equal to {str_b}.
##     Params:
##       str_a: Expected value.
##       str_b: Variable to test.
@@assert.equal() { # str_a str_b
  if ! [ "$1" = "$2" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

##   @@assert.notEqual str_a str_b
##     Test if {str_a} is different to {str_b}.
##     Params:
##       str_a: Unexpected value.
##       str_b: Variable to test.
@@assert.notEqual() { # str_a str_b
  if [ "$1" = "$2" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

##   @@assert.contains str_base str_search
##     Test if {str_base} contains {str_search}.
##     Params:
##       str_base:   String where search.
##       str_search: String to search.
@@assert.contains() { # str_base str_search
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$1" == *"$2"* ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

##   @@assert.notContains str_base str_search
##     Test if {str_base} doesn't contains {str_search}.
##     Params:
##       str_base:   String where search.
##       str_search: String to search.
@@assert.notContains() { # str_base str_search
  if [ -z "$1" ] || [ -z "$2" ] || [[ "$1" == *"$2"* ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

##   @@assert.startWith str_base str_search_start
##     Test if {str_base} starts with {str_search_start}.
##     Params:
##       str_base:         String where search.
##       str_search_start: String to search.
@@assert.startWith() { # str_base str_search_start
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$1" == "$2"* ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

##   @@assert.endWith str_base str_search_end
##     Test if {str_base} ends with {str_search_end}.
##     Params:
##       str_base:       String where search.
##       str_search_end: String to search.
@@assert.endWith() { # str_base str_search_end
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$1" == *"$2" ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] [$2] ($(caller))"
  fi
  return 0
}

##   @@assert.stdOut cmd
##     Test if {cmd} have standard output.
##     Params:
##       cmd: Command to execute.
@@assert.stdOut() { # cmd
  local result="$( eval "$1" 2>/dev/null 3>/dev/null )"
  if [ -z "${result}" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

##   @@assert.noStdOut cmd
##     Test if {cmd} doesn't have standard output.
##     Params:
##       cmd: Command to execute.
@@assert.noStdOut() { # cmd
  local result="$( eval "$1" 2>/dev/null 3>/dev/null )"
  if [ ! -z "${result}" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

##   @@assert.errOut cmd
##     Test if {cmd} have error output.
##     Params:
##       cmd: Command to execute.
@@assert.errOut() { # cmd
  local result="$( ( eval "$1" >/dev/null 3>/dev/null ) 2>&1 )"
  if [ -z "${result}" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

##   @@assert.noErrOut cmd
##     Test if {cmd} doesn't have error output.
##     Params:
##       cmd: Command to execute.
@@assert.noErrOut() { # cmd
  local result="$( ( eval "$1" >/dev/null 3>/dev/null ) 2>&1 )"
  if [ ! -z "${result}" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

##   @@assert.noOut cmd
##     Test if {cmd} doesn't have output.
##     Params:
##       cmd: Command to execute.
@@assert.noOut() { # cmd
  local result="$( eval "$1" 2>&1 3>&1 )"
  if [ ! -z "${result}" ]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] Output: [${result}] ($(caller))"
  fi
  return 0
}

##   @@assert.exec fn_name expected_exit [params]
##     Test function.
##     Params:
##       fn_name:       Function name to execute.
##       expected_exit: {Integer} Expected exit code.
##       params:        Function parameters.
##                      Optional.
@@assert.exec() { # fn_name expected_exit [params]
  local fn_name="$1"
  local expected_exit=$2
  local params="$3"

  [ -f "${ASSERTION_EXEC_OUT_STD}" ] && rm -f "${ASSERTION_EXEC_OUT_STD}"
  [ -f "${ASSERTION_EXEC_OUT_ERR}" ] && rm -f "${ASSERTION_EXEC_OUT_ERR}"
  [ -f "${ASSERTION_EXEC_OUT_INF}" ] && rm -f "${ASSERTION_EXEC_OUT_INF}"

  local cmd="${fn_name} ${params}"
  (
    eval "${cmd}" \
       >"${ASSERTION_EXEC_OUT_STD}" \
      2>"${ASSERTION_EXEC_OUT_ERR}" \
      3>"${ASSERTION_EXEC_OUT_INF}"
    exit $?
  )
  local result=$?

  if [[ "${expected_exit}" =~ ^[0-9][0-9]*$ ]]; then
    [[ ${result} -eq ${expected_exit} ]] \
      && @@assert._testAssertFail "${cmd}" ${result} ${expected_exit} "$(caller)"
  elif ${expected_exit}; then
    [[ ${result} -ne 0 ]] \
      && @@assert._testAssertFail "${cmd}" ${result} ${expected_exit} "$(caller)"
  else
    [[ ${result} -eq 0 ]] \
      && @@assert._testAssertFail "${cmd}" ${result} ${expected_exit} "$(caller)"
  fi

  return 0
}

##   @@assert.regExp reg_exp str
##     Test if {str} match with {reg_exp}.
##     Params:
##       reg_exp: RegExp to match.
##       str:     String to check.
@@assert.regExp() { # reg_exp str
  if [ -z "$1" ] || [ -z "$2" ] || ! [[ "$2" =~ $1 ]]; then
    @@assert._assertFail "${FUNCNAME[0]} [$1] ($(caller))"
  fi
  return 0
}
