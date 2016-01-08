## action [-f]
## Install auto-complete and bin files in current user shell.
## Params:
##   action: Action to do. Valid values:
##     install: Install auto-complete funcion. Use "-f" to force re-install.
##     uninstall: Uninstall auto-complete function. Use "-f" for no inreractive mode.
##   -f: Force action (no interactive).

[ -z "$HOME" ] || [ ! -d "$HOME" ] && error "Invalid Env \$HOME='$HOME'"

local action="$1"
local force="$2"

local scrpt="`file_name "$BASE_SOURCE"`"
local bcfile="$HOME/.${scrpt}_completion"
local bcline="source $bcfile"
local rcs=".bashrc .zshrc .shrc"
local l="PATH=\"$BASE_DIR:\$PATH\" ; export PATH=\"\$PATH\" ; $bcline"
local p
local r

if [ "$force" == "-f" ]; then
	force=true
else
	force=false
fi

case "$action" in
	"install")
		if $force || [ ! -f "$bcfile" ]; then
			# Create file
			e "Creating '$(style bold)$bcfile$(style default)' file..."

			echo "# bash completion for $scrpt (`script_full_path`)" > "$bcfile"
			echo "_${scrpt}_methods() {" >> "$bcfile"
			echo "	grep \"^\\s*\\(function\\s\\+\\)\\?__.\\+()\\s*{.*\$\" \"\${1}\" | while read line ; do" >> "$bcfile"
			echo "		echo \"\$line\" | sed \"s/()\\s*{.*//g\" | sed \"s/\\s*\\(function\\s\\+\\)\\?__//g\"" >> "$bcfile"
			echo "	done" >> "$bcfile"
			echo "}" >> "$bcfile"
			echo "_${scrpt}_lst() {" >> "$bcfile"
			echo "	if [ -d \"${ACTIONS_PATH}\" ]; then" >> "$bcfile"
			echo "		for f in ${ACTIONS_PATH}/* ; do" >> "$bcfile"
			echo "			if [ -f \"\${f}\" ]; then" >> "$bcfile"
			echo "				basename \"\${f}\" | sed 's/\..*\$//g'" >> "$bcfile"
			echo "			fi" >> "$bcfile"
			echo "		done" >> "$bcfile"
			echo "	fi" >> "$bcfile"
			echo "	_${scrpt}_methods \"`script_full_path`\"" >> "$bcfile"
			echo "	_${scrpt}_methods \"${BASHX_BASE_SOURCE}\"" >> "$bcfile"
			echo "}" >> "$bcfile"
			echo "_${scrpt}() {" >> "$bcfile"
			echo "	local cur" >> "$bcfile"
			echo "	COMPREPLY=()" >> "$bcfile"
			echo "	cur=\${COMP_WORDS[COMP_CWORD]}" >> "$bcfile"
			echo "	COMPREPLY=( \$( compgen -W '\$( _${scrpt}_lst )' -- \$cur  ) )" >> "$bcfile"
			echo "}" >> "$bcfile"
			echo "_${scrpt}_zsh() {" >> "$bcfile"
			echo "	compadd \`_${scrpt}_lst\`" >> "$bcfile"
			echo "}" >> "$bcfile"
			echo "if type complete >/dev/null 2>/dev/null; then" >> "$bcfile"
			echo "	# bash" >> "$bcfile"
			echo "	complete -F _${scrpt} ${scrpt}" >> "$bcfile"
			echo "else if type compdef >/dev/null 2>/dev/null; then" >> "$bcfile"
			echo "	# zsh" >> "$bcfile"
			echo "	compdef _${scrpt}_zsh ${scrpt}" >> "$bcfile"
			echo "fi; fi" >> "$bcfile"
		fi

		for r in $rcs ; do
			p="$HOME/$r"
			if [ -f "$p" ]; then
				if grep "$l" "$p" &> $DEV_NULL
					then
						e "Already installed in '$(style bold)$r$(style default)'"
					else
						e "Installing in '$(style bold)$r$(style default)'..."
						echo >> "$p"
						echo "$l" >> "$p"
					fi
			fi
		done

		e "Done!"
	;;
	"uninstall")
		e "Uninstalling..."
		if [ -f "$bcfile" ]; then
			# Delete file
			e "Deleting '$(style bold)$bcfile$(style default)' file..."
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
				if grep "$l" "$p" &> $DEV_NULL
					then
						e "Removing from '$(style bold)$r$(style default)'..."
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

		e "Done!"
	;;
	*)
		# Invalid action
		error "Invalid action '$(style bold)$action$(style default)'"
	;;
esac