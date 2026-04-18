# BashX — Development Notes

## Set / Create New Version

To release a new version, find all occurrences of the current version string (e.g. `v3.2.0`) across the project and replace them with the new version tag.

### Files that contain the version string

| File | Context |
|------|---------|
| `README.md` | Bootstrap blocks shown in "Manual start" examples (appears twice) |
| `docs/actions.md` | `_bashx init project` usage examples |
| `docs/testing.md` | `@@assert.regExp` example output |
| `src/actions/_bashx.xsh` | Inline usage example in `##` doc comment |
| `DEV_NOTES.md` | Version references in step examples |
| `bashx.src/actions/set-version.xsh` | Version reference in `##` doc comment |

### Steps

1. Determine the new version tag (e.g. `v3.3.0`).
2. Run the `set-version` script:
   ```bash
   ./bashx set-version v3.3.0
   ```
3. Verify no stale references remain:
   ```bash
   grep -r "v3.2.0" .
   ```
4. Commit, tag with the version name, and push:
   ```bash
   git add -p
   git commit -m "v3.3.0 updated"
   git tag "v3.3.0"
   git push && git push --tags
   ```

### Notes

- The `bashx` entrypoint itself uses `BASHX_VERSION="master"` — this is intentional (it runs from source). Do **not** change it.
- `src/actions/_bashx/task/init/project.xsh` uses a shell variable `${bashx_version}` (passed at runtime), not a hardcoded tag — do **not** change it.
- `src/bootstrap.src` and `src/init.sh` reference `BASHX_VERSION` as a variable — do **not** change them.
