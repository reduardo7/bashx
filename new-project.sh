#!/usr/bin/env bash

export BASHX_DIR="."
. ./init

BASHX_VERSION="$1"
PROJECT_NAME="$2"

_usg() {
  @error "Usage: ${SCRIPT_CALLED} BASHX_VERSION PROJECT_NAME" false
}

[ ! -z "${BASHX_VERSION}" ] || _usg
[ ! -z "${PROJECT_NAME}" ] || _usg

if [ -f "${PROJECT_NAME}" ] || [ -d "${PROJECT_NAME}" ]; then
  @error "File or directory ${PROJECT_NAME} already exists" false
fi

###############################################################################

@print Preparing source...

init_script="$(@script-minify < src/init-app.sh)"

###############################################################################

@print Writting file ${PROJECT_NAME}...

touch "${PROJECT_NAME}"

cat > "${PROJECT_NAME}" <<EOF
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

chmod a+x "${PROJECT_NAME}"

###############################################################################

@print Project created at ${PROJECT_NAME}
