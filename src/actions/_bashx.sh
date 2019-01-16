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
##                  Create configuration file if not exists from
##                  ${BX_APP_CONFIG_FILE} constant.
##       `project`: Initialize project.
##         {value1}: BashX version for new project.
##                   See https://github.com/reduardo7/bashx/releases for available versions.
##         {value2}: Project script name with path.
##         {value3}: New project title.
##                   Optional. Default: read from {value2}.
##
##   {task} == `resource`
##     {action}:
##       `add`: Add new resource.
##         {value1}: File or directory path to add.
##         {value2}: Destination file or directory name.
##                   Optional. Default: {value1} base name.
##
## Examples:
##   * Add "foo" to Actions:
##       _bashx action add foo
##   * Remove "bar" from Utils:
##       _bashx util remove bar
##   * Initialize project:
##       _bashx init project v1.6.3 ~/project/my-script 'My Super-Script'

@title "$(@style bold color:red)BashX$(@style default) Framework Utils"

local task="$1"
local action="$2"
local value1="$3"
local value2="$4"
local value3="$5"

@load-functions "${BASHX_SRC_PATH}/fwUtils" 'fwUtils.'

if [ ! -z "${task}" ]; then
  case "${task}" in
    action|actions) fwUtils.taskAction "${action}" "${value1}" ;;
    test|tests) fwUtils.taskTest "${action}" "${value1}" ;;
    util|utils) fwUtils.taskUtil "${action}" "${value1}" ;;
    event|events) fwUtils.taskEvent "${action}" "${value1}" ;;
    resource|resources) fwUtils.taskResource "${action}" "${value1}" "${value2}" ;;
    init) case "${action}" in
        config) fwUtils.taskInitConfig ;;
        project) fwUtils.taskInitProject "${value1}" "${value2}" "${value3}" ;;
        *) @warn 'Invalid init action!' ;;
      esac ;;
    *) @warn 'Invalid task!' ;;
  esac
fi

# Usage
@print
@usage "${BASHX_ACTIONS_PATH}/_bashx.sh"
@end 1
