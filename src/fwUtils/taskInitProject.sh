## bashx_version project_path [project_title]
## Initialize project.
##
## Params:
##   bashx_version: BashX version for new project.
##   project_path:  Project script name with path.
##   project_title: New project title.
##                  Optional. Default: read from {project_path}.

local bashx_version="$1"
local project_path="$2"
local project_title="$3"
local init_script

if [ ! -z "${bashx_version}" ] && [ ! -z "${project_path}" ]; then
  if [ -f "${project_path}" ] || [ -d "${project_path}" ]; then
    @error "File or directory ${project_path} already exists"
  fi

  if [ -z "${project_title}" ]; then
    project_title="$(@file-name "${project_path}" true)"
  fi

  local project_env=".${project_title}.env"

  ###############################################################################

  @print "Preparing source..."

  init_script="$(@script-minify < "${BASHX_SRC_PATH}/init-app.sh")" || @error "Error preparing source"

  ###############################################################################

  @print "Writting file ${project_path}..."

  touch "${project_path}" || @error "Can not write '${project_path}'"

  cat > "${project_path}" <<EOF
#!/usr/bin/env bash

###############################################################################
# BashX | https://github.com/reduardo7/bashx
set +ex;export BASHX_VERSION="${bashx_version}"
(${init_script}) || exit \$?
. "\${HOME:-/tmp}/.bashx/\${BASHX_VERSION}/init"
###############################################################################

### Begin Example ###

# Configuration Example.
# This section can be moved to "${project_env}" file.
export BX_APP_TITLE="${project_title}"
export BX_APP_VERSION="1.0"

${BASHX_ACTION_PREFIX}.action1() { # \\\\n Action without arguments
  # ... Your code here ...
  @print Action 1
}

${BASHX_ACTION_PREFIX}.action2() { # param1 param2 \\\\n Action with arguments
  # ... Your code here ...
  @print Action 2
  @print Param1: \$1
  @print Param2: \$2
}

### End Example ###

# Run APP
@run-app "\$@"
EOF

  chmod a+x "${project_path}"

  ###############################################################################

  @print "Project created at ${project_path}"
  @end
fi
