## task action name
## BashX Framework Utils.
##
## Params:
##   task:   {Constant} Task.
##           Values:
##             action: Actions.
##             util:   Utils.
##             test:   Tests.
##             event:  Event.
##   action: {Constant} Action to do.
##           Values:
##             add:    Add task.
##             remove: Remove task.
##   name:   {String} Script name.
##           If {action == "event"} then the {name} parameter can be:
##             invalid-action: Triggered on invalid action called.
##             start:          Triggered on start.
##             error:          Triggered on error (exit code != 0).
##             exit:           Triggered on exit.
##
## Examples:
##   * Add "foo" to Actions:
##       _bashx action add foo
##   * Remove "bar" from Utils:
##       _bashx util remove bar

@title "$(@style bold color:red)BashX$(@style default) Framework Utils"

local task="$1"
local action="$2"
local name="$3"
local hs='#' ; hs="${hs}${hs}"

_doAction() {
  local action="$1"
  local name="$2"
  local path="$3"
  local script="${path}/${name}.sh"

  case "${action}" in
    # Add
    add)
      if [ ! -d "${path}" ]; then
        mkdir -p "${path}" || @error "Can not create directory '$(@style bold color:blue)${path}$(@style default)'"
        @print "Directory '$(@style bold color:blue)${path}$(@style default)' $(@style bold color:green)created$(@style default)!"
      fi

      if [ -f "${script}" ]; then
        @warn "Script '$(@style bold color:blue)${script}$(@style default)' already exists!"
      else
        cat /dev/stdin >"${script}" || @error "Can not create file '$(@style bold color:blue)${script}$(@style default)'"
        @print "Script '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:green)added$(@style default)!"
      fi

      @end
      ;;

    # Remove
    remove)
      if [ -d "${path}" ]; then
        if [ -f "${script}" ]; then
          rm -f "${script}" || @error "Can not remove file '$(@style bold color:blue)${script}$(@style default)'"
          @print "File '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:red)deleted$(@style default)!"
        fi

        # Empty directory?
        if [ -z "$(ls -A "${path}")" ]; then
          rm -rf "${path}" || @error "Can not remove directory '$(@style bold color:blue)${path}$(@style default)'"
          @print "Directory '$(@style bold color:blue)${path}$(@style default)' now is empty, $(@style bold color:red)deleted$(@style default)!"
        fi
      fi

      @end
      ;;

    *) @warn 'Invalid action!' ;;
  esac
}

if [ ! -z "${name}" ] && [ ! -z "${action}" ] && [ ! -z "${task}" ]; then
  case "${task}" in

    action|actions) _doAction "${action}" "${name}" "${ACTIONS_PATH}" <<EOF
${hs} param1 [param2]
${hs} Description...
${hs}
${hs} Params:
${hs}   param1: {String} Description...
${hs}   param2: {Type} Description...
${hs}           Optional. Default: ...

@error '@TODO Implement me!'
EOF
      ;;

    test|tests) _doAction "${action}" "${name}" "${TESTS_PATH}" <<EOF
${hs} Description...

@error '@TODO Implement me!'
EOF
      ;;

    util|utils) _doAction "${action}" "${name}" "${UTILS_PATH}" <<EOF
${hs} param1 [param2]
${hs} Description...
${hs}
${hs} Params:
${hs}   param1: {String} Description...
${hs}   param2: {Type} Description...
${hs}           Optional. Default: ...

@error '@TODO Implement me!'
EOF
      ;;

    event|events)
      if @array-contains "${name}" "${EVENTS_OPTS[@]}"; then
        _doAction "${action}" "${name}" "${EVENTS_PATH}" <<EOF
${hs} Description...

@error '@TODO Implement me!'
EOF
      else
        @warn 'Invalid name!'
      fi
      ;;

    *) @warn 'Invalid task!' ;;

  esac
fi

# Usage
@print
@usage "${BASHX_ACTIONS_PATH}/_bashx.sh"
@end 1
