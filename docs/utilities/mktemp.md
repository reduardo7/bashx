# Temporary Files — `@mktemp`

**File:** `src/utils/mktemp.xsh`

Safe temporary file and directory creation. All temps are placed inside `$BASHX_APP_TMP_PATH`, which is automatically removed when the script exits (via `@app.exit`).

---

## `@mktemp`

```
@mktemp [create [type]]
```

Create a temporary file or directory and print its path.

| Param | Type | Default | Description |
|---|---|---|---|
| `create` | Boolean | `true` | Actually create the file/directory |
| `type` | Constant | `f` | `f`/`file` = file, `d`/`dir`/`directory` = directory |

```bash
# Create a temp file (default)
tmpfile="$(@mktemp)"
echo "data" > "${tmpfile}"

# Create a temp directory
tmpdir="$(@mktemp true d)"
cp -r ./src "${tmpdir}/"

# Reserve a path without creating the file
reserved="$(@mktemp false)"
some_command --output "${reserved}"
cat "${reserved}"
```

```bash
# Practical: capture output of a long command
log="$(@mktemp)"
run_build 2>&1 | tee "${log}"

if grep -q "ERROR" "${log}"; then
  @app.error "Build failed. See log above."
fi
# ${log} is automatically cleaned up on exit
```

> All paths created with `@mktemp` live under `$BASHX_APP_TMP_PATH` and are deleted when `@app.exit` runs — no manual cleanup needed.
