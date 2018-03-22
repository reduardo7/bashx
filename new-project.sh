#!/usr/bin/env bash

set -e

BASHX_VERSION="$1"
PROJECT_NAME="$2"
_ACTION_PREFIX="@Actions"

_log() {
  echo "# $*"
}

_err() {
  _log "Error! $*"
  exit 1
}

if [ -f "${PROJECT_NAME}" ] || [ -d "${PROJECT_NAME}" ]; then
  _err File or directory ${PROJECT_NAME} already exists
fi

###############################################################################

_log Preparing source...

code="$(cat app.src | grep -v -E '^\s*#.*' | sed '/^\s*$/d')"

###############################################################################

_log Writting file ${PROJECT_NAME}...

touch "${PROJECT_NAME}"

cat > "${PROJECT_NAME}" <<EOF
#!/usr/bin/env bash

# BashX | https://github.com/reduardo7/bashx
export BASHX_VERSION="${BASHX_VERSION}"
bash -c "\$(echo '$(echo "${code}" | base64)' | base64 -d)" || exit \$?
. "\${HOME}/.bashx/\${BASHX_VERSION}/init"

### Begin Example ###

${_ACTION_PREFIX}.action1() { # \\\\n Action without arguments
  # ... Your code here ...
  @print Action 1
}

${_ACTION_PREFIX}.action2() { # param1 param2 \\\\n Action with arguments
  # ... Your code here ...
  @print Action 2
  @print Param1: \$1
  @print Param2: \$2
}

### End Example ###

@init "\$@"
EOF

chmod a+x "${PROJECT_NAME}"

###############################################################################

_log Project created at ${PROJECT_NAME}
