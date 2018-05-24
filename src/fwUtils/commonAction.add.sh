local name="$1"
local path="$2"
local script="${path}/${name}.sh"

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
