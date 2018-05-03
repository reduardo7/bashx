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

set -e

_x() {
  echo "# Error: ${1:-Installation fail}" >&2
  exit 1
}

[ -z "${BASHX_VERSION}" ] && _x 'BASHX_VERSION is required'

export BASHX_DIR="${BASHX_DIR:-$HOME/.bashx/$BASHX_VERSION}"

if [ ! -d "$BASHX_DIR" ]; then
  export setup_url='https://raw.githubusercontent.com/reduardo7/bashx/master/src/setup.sh'
  if type wget >/dev/null 2>&1 ; then
    sh -c "$(wget -q $setup_url -O -)" || _x
  elif type curl >/dev/null 2>&1 ; then
    sh -c "$(curl -fsSL $setup_url)" || _x
  else
    _x 'wget or curl are required. Install wget or curl to continue'
  fi
fi
