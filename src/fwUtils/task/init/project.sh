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
    @app.error "File or directory ${project_path} already exists"
  fi

  if [ -z "${project_title}" ]; then
    project_title="$(@file.name "${project_path}" true)"
  fi

  local project_env=".${project_title}.env"

  ###############################################################################

  @log "Preparing source..."

  init_script="$(@file.scriptMinify < "${BX_SRC_PATH}/init-app.sh")" || @app.error "Error preparing source"

  ###############################################################################

  @log "Writting file ${project_path}..."

  touch "${project_path}" || @app.error "Can not write '${project_path}'"

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
export BASHX_APP_TITLE="${project_title}"
export BASHX_APP_VERSION="1.0"

${BX_ACTION_PREFIX}.action1() { # \\\\n Action without arguments
  # ... Your code here ...
  @log Action 1
}

${BX_ACTION_PREFIX}.action2() { # param1 param2 \\\\n Action with arguments
  # ... Your code here ...
  @log Action 2
  @log Param1: \$1
  @log Param2: \$2
}

### End Example ###

# Run APP
@app.run "\$@"
EOF

  chmod a+x "${project_path}"

  ###############################################################################

  @log "Project created at ${project_path}"
  @app.exit
fi
