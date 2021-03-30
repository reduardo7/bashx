## <<
## Script minify.
##
## Input (read from /dev/stdin): Script content.
## Out: {String} Minified script.

# Result
local minify=''

# Current line
local line

while read line; do
  line="$(@str.trim "${line}")"
  minify="$(@str.trim "${minify}")"

  # If it's a non empty line...
  if \
    [[ ! -z "${line}" ]] && \
    [[ "${line}" != '#'* ]]
  then
    if [[ ! -z "${minify}" ]] && \
       [[ "${line}" != ')' ]]
    then
      # If end with...
      if [[ "${minify}" == *'{' ]] || \
         [[ "${minify}" == *'[' ]] || \
         [[ "${minify}" == *';do' ]] || \
         [[ "${minify}" == *' do' ]] || \
         [[ "${minify}" == *';then' ]] || \
         [[ "${minify}" == *' then' ]] || \
         [[ "${minify}" == *';else' ]] || \
         [[ "${minify}" == *' else' ]] || \
         [[ "${minify}" == *'(' ]]
      then
        # Add an extra space at the end
        minify="${minify} "
      else
        # Add `;` at the end
        minify="${minify};"
      fi
    fi

    # Cleanup line
    line="$(@str.replace "${line}" '\s+;\s+' ';')"
    line="$(@str.replace "${line}" '\s+' ' ')"

    # Concat current line
    minify="${minify}${line}"
  fi
done < /dev/stdin

# Script output
echo "${minify}"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
