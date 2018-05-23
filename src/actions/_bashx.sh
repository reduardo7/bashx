## task action value1? value2? value3?
## BashX Framework Utils.
##
## Usage:
##
##   {task} == `action`, `util`, `test`, `event`
##     {action}:
##       `add`:    Add task.
##       `remove`: Remove task.
##     {value1}: Script name.
##
##   {task} == `event`
##     {action}:
##       `add`:    Add event.
##       `remove`: Remove event.
##     {value1}:
##       `invalid-action`: Triggered on invalid action called.
##       `ready`:          Triggered on the initialization is complete.
##       `start`:          Triggered on start, before a valid action is called.
##       `error`:          Triggered on error (exit code != 0).
##       `finish`:         Triggered on execution finished.
##
##   {task} == `init`
##     {action}:
##       `config`:  Initialize configuration file.
##       `project`: Initialize project.
##         {value1}: BashX version for new project.
##         {value2}: Project script name with path.
##         {value3}: New project title.
##                   Optional. Default: read from {value2}.
##
##   {task} == `resource`
##     {action}:
##       `add`: Add new resource.
##         {value1}: File or directory path to add.
##
## Examples:
##   * Add "foo" to Actions:
##       _bashx action add foo
##   * Remove "bar" from Utils:
##       _bashx util remove bar
##   * Initialize project:
##       _bashx init project v1.2 ~/project/my-script 'My Super-Script'

@title "$(@style bold color:red)BashX$(@style default) Framework Utils"

local task="$1"
local action="$2"
local value1="$3"
local value2="$4"
local value3="$5"

@load-functions "${BASHX_SRC_PATH}/fwUtils" 'fwUtils.'

if [ ! -z "${task}" ]; then
  case "${task}" in
    action|actions) fwUtils.doAction "${action}" "${value1}" ;;
    test|tests) fwUtils.doTest "${action}" "${value1}" ;;
    util|utils) fwUtils.doUtil "${action}" "${value1}" ;;
    event|events) fwUtils.doEvent "${action}" "${value1}" ;;
    init) case "${action}" in
      config) fwUtils.initConfig ;;
      project) fwTools.initProject "${value1}" "${value2}" "${value3}" ;;
      *) @warn 'Invalid init action!' ;;
    esac ;;
    *) @warn 'Invalid task!' ;;
  esac
fi

# Usage
@print
@usage "${BASHX_ACTIONS_PATH}/_bashx.sh"
@end 1
