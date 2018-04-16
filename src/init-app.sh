############################################
#                                          #
# BashX                                    #
#                                          #
# Extended Bash Framework.                 #
#                                          #
# URL: https://github.com/reduardo7/bashx  #
#                                          #
# Author: Eduardo Daniel Cuomo             #
#         eduardo.cuomo.ar@gmail.com       #
#         reduardo7@gmail.com              #
#                                          #
############################################

export LC_CTYPE=C
export LC_ALL=C
export BASHX_DIR="${HOME}/.bashx/${BASHX_VERSION}"
export tmp_dir="$(mktemp -d)"

_e() {
  echo "# $*"
}

_w() {
  _e "$*" >&2
}

_err() {
  _w "Error! $*"
  exit 1
}

[ -z "${BASHX_VERSION}" ] && _err 'BASHX_VERSION is required'

# Install
(
set -e
if [ ! -d "${BASHX_DIR}" ]; then
  _e "Installing BashX ${BASHX_VERSION}..."

  m_ed="Error downloading BashX ${BASHX_VERSION}"
  g_repo="https://github.com/reduardo7/bashx/tarball/${BASHX_VERSION}"

  cd "${tmp_dir}"

  if type wget >/dev/null 2>&1 ; then
    wget --no-check-certificate ${g_repo} -O - | tar -xz || _err "${m_ed}"
  elif type curl >/dev/null 2>&1 ; then
    curl -sL ${g_repo} | tar -xz || _err "${m_ed}"
  else
    _err "wget or curl are required! Install wget or curl to continue"
  fi

  mkdir -p "${BASHX_DIR}"
  rm -rf "${BASHX_DIR}"
  mv reduardo7-bashx-* "${BASHX_DIR}"
fi
)
e=$?
# Cleanup
rm -rf "${tmp_dir}" >/dev/null 2>&1
exit $e