## <new-version>
## Update the BashX framework version string across the whole project.
##
## Searches for the current version tag (e.g. v3.2.0) in all tracked files
## and replaces every occurrence with <new-version>, then creates a git tag.
##
## Params:
##   new-version: New version tag, e.g. v3.3.0

local new_version="$1"

[ -z "${new_version}" ] && @throw.invalidParam new-version

# Detect current version from README.md (first BASHX_VERSION= line)
local current_version
current_version="$(grep -m1 'BASHX_VERSION="v' "${BX_SCRIPT_DIR}/README.md" | sed 's/.*BASHX_VERSION="\(v[^"]*\)".*/\1/')"

[ -z "${current_version}" ] && @app.error "Could not detect current version from README.md"

@log "Current version : $(@style bold)${current_version}$(@style)"
@log "New version     : $(@style bold)${new_version}$(@style)"

# Files that contain the hardcoded version string
local files=(
  "${BX_SCRIPT_DIR}/README.md"
  "${BX_SCRIPT_DIR}/docs/actions.md"
  "${BX_SCRIPT_DIR}/docs/testing.md"
  "${BX_SCRIPT_DIR}/src/actions/_bashx.xsh"
  "${BX_SCRIPT_DIR}/DEV_NOTES.md"
  "${BX_SCRIPT_DIR}/bashx.src/actions/set-version.xsh"
)

local f
for f in "${files[@]}"; do
  if grep -q "${current_version}" "${f}" 2>/dev/null; then
    @log "Updating $(@style bold)${f#${BX_SCRIPT_DIR}/}$(@style)..."
    @sed "${f}" "s/${current_version}/${new_version}/g"
  fi
done

@log "Done! Verify with: $(@style bold)grep -r '${current_version}' .$(@style)"
@log ""
@log "Next steps:"
@log "  git add -p"
@log "  git commit -m \"${new_version} updated\""
@log "  git tag \"${new_version}\""
@log "  git push && git push --tags"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
