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

_e(){ echo "# $*";}
_w(){ _e $* >&2;}
_x(){ _w Error: $*;exit 1;}

[ -z "${BASHX_VERSION}" ] && _x BASHX_VERSION is required

export BASHX_DIR="${BASHX_DIR:-$HOME/.bashx/$BASHX_VERSION}"
export t="$(mktemp -d)"

# Install
(
set -e
if [ ! -d "$BASHX_DIR" ]; then
  _e Installing BashX ${BASHX_VERSION}...

  m="Error downloading BashX ${BASHX_VERSION}"
  g="https://github.com/reduardo7/bashx/tarball/${BASHX_VERSION}"

  cd "$t"

  if type wget >/dev/null 2>&1 ; then
    wget --no-check-certificate $g -O - | tar -xz || _x $m
  elif type curl >/dev/null 2>&1 ; then
    curl -sL $g | tar -xz || _x $m
  else
    _x wget or curl are required. Install wget or curl to continue
  fi

  mkdir -p "$BASHX_DIR"
  rm -rf "$BASHX_DIR"
  mv reduardo7-bashx-* "$BASHX_DIR"
fi
)
e=$?
# Cleanup
rm -rf "$t" >/dev/null 2>&1 || true
exit $e
