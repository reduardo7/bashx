## task action name
## BashX Framework Utils.
##
## Params:
##   task:   {Constant} Task.
##           Values:
##             action: Actions.
##             util:   Utils.
##             test:   Tests.
##   action: {Constant} Action to do.
##           Values:
##             add:    Add task.
##             remove: Remove task.
##   name:   {String} Script name.
##
## Examples:
##   * Add "foo" to Actions:
##       _bashx action add foo
##   * Remove "bar" from Utils:
##       _bashx util remove bar

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
        mkdir -v -p "${path}"
        @print "Directory '$(@style bold color:blue)${path}$(@style default)' $(@style bold color:green)created$(@style default)!"
      fi

      if [ ! -f "${script}" ]; then
        cat /dev/stdin >"${script}"
        @print "Script '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:green)added$(@style default)!"
      fi

      @end
      ;;

    # Remove
    remove)
      if [ -d "${path}" ]; then
        if [ -f "${script}" ]; then
          rm -vf "${script}"
          @print "File '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:red)deleted$(@style default)!"
        fi

        # Empty directory?
        if ! [ "$(ls -A "${path}")" ]; then
          rm -rvf "${path}"
          @print "Directory '$(@style bold color:blue)${path}$(@style default)' now is empty, $(@style bold color:red)deleted$(@style default)!"
        fi
      fi

      @end
      ;;
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
    test|tests)     _doAction "${action}" "${name}" "${TESTS_PATH}" <<EOF
${hs} Description...

@error '@TODO Implement me!'
EOF
;;
    util|utils)     _doAction "${action}" "${name}" "${UTILS_PATH}" <<EOF
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
  esac
fi

# Usage

@title "$(@style bold color:red)BashX$(@style default) Framework Utils"
@usage "${BASHX_ACTIONS_PATH}/_bashx.sh"
@end 1
