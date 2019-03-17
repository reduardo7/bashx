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

set -e

x() {
  s="$*"
  echo "# Error: ${s:-Installation fail}" >&2
  exit 1
}

d=/dev/null
[ -z "$BASHX_VERSION" ] && x BASHX_VERSION is required

export BASHX_DIR="${BASHX_DIR:-${HOME:-/tmp}/.bashx/$BASHX_VERSION}"

if [ ! -d "$BASHX_DIR" ]; then
  u='https://raw.githubusercontent.com/reduardo7/bashx/master/src/setup.sh'
  if type wget >$d 2>&1 ; then
    sh -c "$(wget -q $u -O -)" || x
  elif type curl >$d 2>&1 ; then
    sh -c "$(curl -fsSL $u)" || x
  else
    x wget or curl are required. Install wget or curl to continue
  fi
fi
