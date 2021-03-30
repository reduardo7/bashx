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
export LANG=C

_e() {
  echo "# $@"
}

_x() {
  _e "Error: $@" >&2
  exit 1
}

[ -z "${BASHX_VERSION}" ] && _x BASHX_VERSION is required
type tar >/dev/null 2>&1 || _x tar is required. Install tar to continue
export BASHX_DIR="${BASHX_DIR:-${HOME:-/tmp}/.bashx/$BASHX_VERSION}"

if [ ! -d "${BASHX_DIR}" ]; then
  export t="$(mktemp -d)"

  # Install
  (
    set -e
    _e Installing BashX ${BASHX_VERSION}...

    m="Error downloading BashX ${BASHX_VERSION}"
    g="https://github.com/reduardo7/bashx/tarball/${BASHX_VERSION}"

    cd "$t"

    if type wget >/dev/null 2>&1 ; then
      wget -q $g -O - | tar -xz || _x $m
    elif type curl >/dev/null 2>&1 ; then
      curl -sL $g | tar -xz || _x $m
    else
      _x wget or curl are required. Install wget or curl to continue
    fi

    mkdir -p "${BASHX_DIR}"
    rm -rf "${BASHX_DIR}"
    mv reduardo7-bashx-* "${BASHX_DIR}"
  )
  e=$?

  # Cleanup
  rm -rf "$t" >/dev/null 2>&1 || true

  # Finish
  exit $e
fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
