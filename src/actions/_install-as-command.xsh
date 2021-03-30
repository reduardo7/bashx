## [-f] action
## Install auto-complete and bin files in current user shell.
##
## Params:
##   action: {Constant} Action to do. Valid values:
##     install:   Install auto-complete funcion. Use "-f" to force re-install.
##     uninstall: Uninstall auto-complete function. Use "-f" for no inreractive mode.
##
## Options:
##   -f|--force: Force action (no interactive).

eval "$(@args 'force:-f|--force')"

[ -z "${HOME}" ] || [ ! -d "${HOME}" ] && @throw.invalidParam HOME

local action="$1"

local scrpt="${BX_SCRIPT_FILE_NAME}"
local bcfile="${HOME}/.${scrpt}_completion"
local bcline=". ${bcfile}"
local rcs=(.bashrc .zshrc .shrc)
local l="PATH=\"${BX_SCRIPT_DIR}:\$PATH\" ; export PATH=\"\$PATH\" ; ${bcline}"
local p
local r

case "$action" in
  install)
    if ${args_force} || [ ! -f "${bcfile}" ]; then
      # Create file
      @log "Creating '$(@style bold)${bcfile}$(@style)' file..."

      cat > "${bcfile}" <<EOF
# bash completion for $scrpt (${BX_SCRIPT_FULL_PATH})
_${scrpt}_methods() {
  grep \"^\\s*\\(function\\s\\+\\)\\?${BX_ACTION_PREFIX}\\..\\+()\\s*{.*\$\" \"\${1}\" | while read line ; do
    echo \"\$line\" | sed \"s/()\\s*{.*//g\" | sed \"s/\\s*\\(function\\s\\+\\)\\?${BX_ACTION_PREFIX}\\.//g\"
  done
}
_${scrpt}_lst() {
  if [ -d \"${BASHX_ACTIONS_PATH}\" ]; then
    for f in "${BASHX_ACTIONS_PATH}"/*.${BX_SCRIPT_EXTENSION} ; do
      if [ -f \"\${f}\" ]; then
        basename \"\${f}\" | sed 's/\..*\$//g'
      fi
    done
  fi
  _${scrpt}_methods \"${BX_SCRIPT_FULL_PATH}\"
  _${scrpt}_methods \"${BX_BASE_SOURCE}\"
}
_${scrpt}() {
  local cur
  COMPREPLY=()
  cur=\${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( \$( compgen -W '\$( _${scrpt}_lst )' -- \${cur}  ) )
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

    for r in ${rcs[@]} ; do
      p="${HOME}/${r}"

      if [ -f "${p}" ]; then
        if grep -q "${l}" "${p}" ; then
            @log "Already installed at '$(@style bold)${r}$(@style)'"
          else
            @log "Installing in '$(@style bold)${r}$(@style)'..."
            echo >> "${p}"
            echo "${l}" >> "${p}"
          fi
      fi
    done

    @log "Done!"
  ;;
  uninstall)
    @log "Uninstalling..."

    if [ -f "${bcfile}" ]; then
      # Delete file
      @log "Deleting '$(@style bold)${bcfile}$(@style)' file..."

      if ${args_force}; then
        # Force
        rm -f "${bcfile}"
      else
        # Interactive
        rm -i "${bcfile}"
      fi
    fi

    for r in ${rcs[@]} ; do
      p="${HOME}/${r}"
      if [ -f "${p}" ]; then
        if grep "${l}" "${p}" >/dev/null 2>&1
          then
            @log "Removing from '$(@style bold)${r}$(@style)'..."
            if ${args_force}; then
              # Force
              cat "${p}" | grep -v "${l}" > "${p}.2" && mv -f "${p}.2" "${p}"
            else
              # Interactive
              cat "${p}" | grep -v "${l}" > "${p}.2" && mv -i "${p}.2" "${p}"
            fi
          fi
      fi
    done

    @log "Done!"
  ;;
  *)
    # Invalid action
    @throw.invalidParam action
  ;;
esac

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
