#!/usr/bin/env bash

set -e

BASHX_VERSION="$1"
PROJECT_NAME="$2"

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

echo '#!/usr/bin/env bash' >"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"
echo '############################################' >>"${PROJECT_NAME}"
echo '#                                          #' >>"${PROJECT_NAME}"
echo '# BashX                                    #' >>"${PROJECT_NAME}"
echo '#                                          #' >>"${PROJECT_NAME}"
echo '# Extended Bash Framework.                 #' >>"${PROJECT_NAME}"
echo '#                                          #' >>"${PROJECT_NAME}"
echo '# URL: https://github.com/reduardo7/bashx  #' >>"${PROJECT_NAME}"
echo '#                                          #' >>"${PROJECT_NAME}"
echo '# Author: Eduardo Daniel Cuomo             #' >>"${PROJECT_NAME}"
echo '#         eduardo.cuomo.ar@gmail.com       #' >>"${PROJECT_NAME}"
echo '#         reduardo7@gmail.com              #' >>"${PROJECT_NAME}"
echo '#                                          #' >>"${PROJECT_NAME}"
echo '############################################' >>"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"
echo "export BASHX_VERSION=\"${BASHX_VERSION}\" ; bash -c \"\$(echo '$(echo "${code}" | base64)' | base64 -d)\" || exit \$?" >>"${PROJECT_NAME}"
echo ". \"\${HOME}/.bashx/\${BASHX_VERSION}/init\"" >>"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"
echo '# ... Your code here ...' >>"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"
echo '@init "$@"' >>"${PROJECT_NAME}"
echo >>"${PROJECT_NAME}"

chmod a+x "${PROJECT_NAME}"

###############################################################################

_log Project created at ${PROJECT_NAME}
