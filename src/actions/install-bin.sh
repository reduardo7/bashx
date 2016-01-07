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

local bcfile="$HOME/.bash_completion"
local rcs=".bashrc .zshrc .shrc"
local l="PATH=\"$BASE_DIR:\$PATH\" ; export PATH=\"\$PATH\""
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
			echo > "$bcfile"
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
		error "Invalid action '$(style bold)$action$(style default)'"
	;;
esac