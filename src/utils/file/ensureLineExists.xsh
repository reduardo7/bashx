## file line [sudo]
## Ensulre line exists in file.
##
## Params:
##   file: {String} File path.
##   line: {String} Line content.
##   sudo: {Boolean}
##         Optional. Default: false
##
## Return: 0 if line has been added.
##         1 if line already exists.
##         2 on error.

local file="${1}"
local line="${2}"
local sudo=${3:-false}

if grep -qxF "${line}" "${file}"
  then
    # Already exists
    return 1
  else
    if ${sudo}; then
      if @sudo "${file}" "echo >> '${file}' && echo '${line}' >> '${file}'"
        then
          # Line added
          return 0
        else
          # Error
          return 2
        fi
    else
      if echo >> "${file}" && echo "${line}" >> "${file}"
        then
          # Line added
          return 0
        else
          # Error
          return 2
        fi
    fi
  fi

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
