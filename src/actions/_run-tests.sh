## [*]
## Run tests.
##
## Params:
##   *: {String} Tests names to execute separated by a space.
##      If not setted, all tests will be executed.
##      Optional.

local tests_names_to_execute=($@)

local error_count=0
local count=0
local test_result
local test_success_flag="$(@mktemp false)"

@asserts.load

###############################################################################
# Tests

if [ -d "${BASHX_TESTS_PATH}" ]; then
  for f in "${BASHX_TESTS_PATH}"/* ; do
    if [ -f "${f}" ]; then
      local src_test_name="$(@file.name "${f}" true)"
      if [ -z "${tests_names_to_execute}" ] \
        || @array.contains "${src_test_name}" "${tests_names_to_execute[@]}"
        then
        @log "$(@style color:yellow)Testing ${src_test_name}..."
        count=$((count+1))

        [ -f "${test_success_flag}" ] && rm -f "${test_success_flag}"
        (
          BX_APP_EXIT=true
          . "${f}"
          exit_code=$?
          touch "${test_success_flag}" || @app.error
          exit ${exit_code}
        )
        test_result=$?

        if [[ ${test_result} -eq 0 ]]; then
            # Success
            @log "$(@style color:green)Success"
          else
            # Error
            error_count=$((error_count+1))

            if [ ! -f "${test_success_flag}" ]; then
              @log.warn "Warning: No exit from assert"
            fi

            @log.alert "Fail! Exit code: ${test_result}"
          fi

        @log
        @log.line
        @log
      fi
    fi
  done
fi

###############################################################################
# Finish

@log "Tests executed: ${count}"
@log

if [[ ${error_count} -eq 0 ]]; then
  @log 'All tests success!'
  exit 0
else
  @app.error "${error_count} tests fail!"
fi
