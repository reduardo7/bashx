## action [-f]
## Install auto-complete and bin files in current user shell.
##
## Params:
##   action: {Constant} Action to do. Valid values:
##     install:   Install auto-complete funcion. Use "-f" to force re-install.
##     uninstall: Uninstall auto-complete function. Use "-f" for no inreractive mode.
##   -f:     {Constant} Force action (no interactive).
##           Optional. Default: "".

[ -z "$HOME" ] || [ ! -d "$HOME" ] && @throw-invalid-param "$0" HOME

local action="$1"
local force="$2"

local scrpt="${SCRIPT_FILE_NAME}"
local bcfile="${HOME}/.${scrpt}_completion"
local bcline=". $bcfile"
local rcs=(.bashrc .zshrc .shrc)
local l="PATH=\"$SCRIPT_DIR:\$PATH\" ; export PATH=\"\$PATH\" ; $bcline"
local p
local r

if [ "$force" == "-f" ]; then
  force=true
else
  force=false
fi

case "$action" in
  install)
    if $force || [ ! -f "$bcfile" ]; then
      # Create file
      @print "Creating '$(@style bold)$bcfile$(@style default)' file..."

      cat > "$bcfile" <<EOF
# bash completion for $scrpt ($SCRIPT_FULL_PATH)
_${scrpt}_methods() {
  grep \"^\\s*\\(function\\s\\+\\)\\?${ACTION_PREFIX}\\..\\+()\\s*{.*\$\" \"\${1}\" | while read line ; do
    echo \"\$line\" | sed \"s/()\\s*{.*//g\" | sed \"s/\\s*\\(function\\s\\+\\)\\?${ACTION_PREFIX}\\.//g\"
  done
}
_${scrpt}_lst() {
  if [ -d \"${ACTIONS_PATH}\" ]; then
    for f in ${ACTIONS_PATH}/* ; do
      if [ -f \"\${f}\" ]; then
        basename \"\${f}\" | sed 's/\..*\$//g'
      fi
    done
  fi
  _${scrpt}_methods \"${SCRIPT_FULL_PATH}\"
  _${scrpt}_methods \"${BASHX_BASE_SOURCE}\"
}
_${scrpt}() {
  local cur
  COMPREPLY=()
  cur=\${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( \$( compgen -W '\$( _${scrpt}_lst )' -- \$cur  ) )
}
_${scrpt}_zsh() {
  compadd \`_${scrpt}_lst\`
}
if type complete >/dev/null 2>/dev/null; then
  # bash
  complete -F _${scrpt} ${scrpt}
else if type compdef >/dev/null 2>/dev/null; then
  # zsh
  compdef _${scrpt}_zsh ${scrpt}
fi; fi
EOF
    fi

    for r in $rcs ; do
      p="$HOME/$r"

      if [ -f "$p" ]; then
        if grep -q "$l" "$p" ; then
            @print "Already installed at '$(@style bold)$r$(@style default)'"
          else
            @print "Installing in '$(@style bold)$r$(@style default)'..."
            echo >> "$p"
            echo "$l" >> "$p"
          fi
      fi
    done

    @print "Done!"
  ;;
  uninstall)
    @print "Uninstalling..."

    if [ -f "$bcfile" ]; then
      # Delete file
      @print "Deleting '$(@style bold)$bcfile$(@style default)' file..."

      if $force; then
        # Force
        rm -f "$bcfile"
      else
        # Interactive
        rm -i "$bcfile"
      fi
    fi

    for r in $rcs ; do
      p="$HOME/$r"
      if [ -f "$p" ]; then
        if grep "$l" "$p" >/dev/null 2>&1
          then
            @print "Removing from '$(@style bold)$r$(@style default)'..."
            if $force; then
              # Force
              cat "$p" | grep -v "$l" > "${p}.2" && mv -f "${p}.2" "$p"
            else
              # Interactive
              cat "$p" | grep -v "$l" > "${p}.2" && mv -i "${p}.2" "$p"
            fi
          fi
      fi
    done

    @print "Done!"
  ;;
  *)
    # Invalid action
    @throw-invalid-param "$0" action
  ;;
esac
