## src line [backup]
## Ensure that line is present in the file.
##
## Params:
##   src:    {String} File where search for {line}.
##   line:   {String} Line that must be present in the file {src}.
##   backup: {Boolean} Make backup before edit file?

local src="$1"
local line="$2"
local backup=${3:-true}
local src_dir="$(dirname "${src}")"

if [ -f "${src}" ]; then
  # File exists
  if ! grep -Fxq "${line}" ${src} >/dev/null 2>&1
    then
      if ${backup}; then
        # Create backup
      fi

      # File not contains line
      @print "Adding [${line}] to [${src}]..."
      @sudo "${src}" "echo >> ${src}"
      @sudo "${src}" "echo '${line}' >> ${src}"
    fi
else
  # File not exists

  # Create directory if not exists
  if [ ! -d "${src_dir}"]; then
    @print "Creating directory [${src_dir}]..."
    @sudo "${src_dir}" "mkdir -p '${src_dir}'"
  fi

  # Create file
  @print "Creating file [${src}] and writting [${line}]..."
  @sudo "${src_dir}" "echo '${line}' >> ${src}"
fi
