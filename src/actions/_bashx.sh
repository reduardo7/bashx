## task action? name? | task bashx_ver project_path [title]
## BashX Framework Utils.
##
## Params:
##   task:          {Constant} Task.
##                  Values:
##                    action:       Actions.
##                    util:         Utils.
##                    test:         Tests.
##                    event:        Event.
##                    init-config:  Initialize configuration file.
##                                  Param {name} will not be used.
##                    init-project: Initialize project.
##   action:        {Constant} Action to do.
##                  Values:
##                    add:    Add task.
##                    remove: Remove task.
##                 Optional for {task == 'init-config'}.
##   name:         {String} Script name.
##                 If {action == "event"} then the {name} parameter can be:
##                   invalid-action: Triggered on invalid action called.
##                   ready:          Triggered on the initialization is complete.
##                   start:          Triggered on start, before a valid action is called.
##                   error:          Triggered on error (exit code != 0).
##                   finish:         Triggered on execution finished.
##                 Optional for {task == 'init-config'}.
##   bashx_ver:    {String} BashX version for new project.
##   project_path: {String} Project script name with path.
##   title:        {String} New project title.
##                 Optional. Default: read from {project_path}.
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

_initProject() {
  local BASHX_VERSION="$1"
  local PROJECT_PATH="$2"
  local PROJECT_TITLE="$3"

  if [ ! -z "${BASHX_VERSION}" ] && [ ! -z "${PROJECT_PATH}" ]; then
    if [ -f "${PROJECT_PATH}" ] || [ -d "${PROJECT_PATH}" ]; then
      @error "File or directory ${PROJECT_PATH} already exists"
    fi

    if [ -z "${PROJECT_TITLE}" ]; then
      PROJECT_TITLE="$(@file-name "${PROJECT_PATH}" true)"
    fi

    ###############################################################################

    @print "Preparing source..."

    init_script="$(@script-minify < "${BASHX_SRC_PATH}/init-app.sh")" || @error "Error preparing source"

    ###############################################################################

    @print "Writting file ${PROJECT_PATH}..."

    touch "${PROJECT_PATH}" || @error "Can not write '${PROJECT_PATH}'"

    cat > "${PROJECT_PATH}" <<EOF
#!/usr/bin/env bash

# BashX | https://github.com/reduardo7/bashx
export BASHX_VERSION="${BASHX_VERSION}"
(${init_script}) || exit \$?
. "\${HOME}/.bashx/\${BASHX_VERSION}/init"

### Begin Example ###

${ACTION_PREFIX}.action1() { # \\\\n Action without arguments
  # ... Your code here ...
  @print Action 1
}

${ACTION_PREFIX}.action2() { # param1 param2 \\\\n Action with arguments
  # ... Your code here ...
  @print Action 2
  @print Param1: \$1
  @print Param2: \$2
}

### End Example ###

# Run APP
@run-app "\$@"
EOF

    chmod a+x "${PROJECT_PATH}"

    ###############################################################################

    @print "Project created at ${PROJECT_PATH}"
    @end
  fi
}

_initConfig() {
  if [ -f "${APP_CONFIG_FILE}" ]; then
    @warn "Configuration file '$(@style bold color:blue)${APP_CONFIG_FILE}$(@style default)' already exists!"
  else
    touch "${APP_CONFIG_FILE}" || @error "Can not create file '$(@style bold color:blue)${APP_CONFIG_FILE}$(@style default)'"
    @print "Configuration file '$(@style bold color:blue)${APP_CONFIG_FILE}$(@style default)' $(@style bold color:green)added$(@style default)!"
  fi

  @end
}

_doAction() {
  local action="$1"
  local name="$2"
  local path="$3"
  local script="${path}/${name}.sh"

  if [ ! -z "${name}" ] && [ ! -z "${action}" ]; then
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
  fi
}

if [ ! -z "${task}" ]; then
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

    init-config) _initConfig ;;

    init-project) _initProject "$2" "$3" "$4" ;;

    *) @warn 'Invalid task!' ;;

  esac
fi

# Usage
@print
@usage "${BASHX_ACTIONS_PATH}/_bashx.sh"
@end 1
