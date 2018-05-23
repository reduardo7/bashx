## action name path
## Setup
##
## Params:
##   action: {Constant} Action to do.
##           Values:
##             add:    Add resource.
##             remove: Remove resource.
##   name:   {String} Resource name.
##   path:   {String} Path where generate the resource.
##
## Input: Source code.

local action="$1"
local name="$2"
local path="$3"
local script="${path}/${name}.sh"

if [ ! -z "${name}" ] && [ ! -z "${action}" ]; then
  case "${action}" in
    # Add
    add)
      if [ ! -d "${path}" ]; then
        mkdir -p "${path}" || @error "Can not create directory '$(@style bold color:blue)${path}$(@style default)'"
        @print "Directory '$(@style bold color:blue)${path}$(@style default)' $(@style bold color:green)created$(@style default)!"
      fi

      if [ -f "${script}" ]; then
        @warn "Script '$(@style bold color:blue)${script}$(@style default)' already exists!"
      else
        cat /dev/stdin >"${script}" || @error "Can not create file '$(@style bold color:blue)${script}$(@style default)'"
        @print "Script '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:green)added$(@style default)!"
      fi

      @end
      ;;

    # Remove
    remove)
      if [ -d "${path}" ]; then
        if [ -f "${script}" ]; then
          rm -f "${script}" || @error "Can not remove file '$(@style bold color:blue)${script}$(@style default)'"
          @print "File '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:red)deleted$(@style default)!"
        fi

        # Empty directory?
        if [ -z "$(ls -A "${path}")" ]; then
          rm -rf "${path}" || @error "Can not remove directory '$(@style bold color:blue)${path}$(@style default)'"
          @print "Directory '$(@style bold color:blue)${path}$(@style default)' now is empty, $(@style bold color:red)deleted$(@style default)!"
        fi
      fi

      @end
      ;;

    *) @warn 'Invalid action!' ;;
  esac
fi
