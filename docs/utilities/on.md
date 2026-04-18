# On / Callbacks — `@on.*`

Register callbacks for application lifecycle events.

---

## `@on.exit`

**File:** `src/utils/on/exit.xsh`

```
@on.exit command...
```

Register a command to run when the application exits (via `@app.exit`). Multiple calls append commands; all are executed in order. The current exit code is available as `$EXIT_CODE`.

```bash
# Clean up a lock file on exit
lockfile="/tmp/myapp.lock"
touch "${lockfile}"
@on.exit "rm -f '${lockfile}'"

# Log the exit code
@on.exit "@log \"Exiting with code: \${EXIT_CODE}\""

# Send notification on failure
@on.exit "if [[ \${EXIT_CODE} -ne 0 ]]; then @log.warn 'Script failed!'; fi"
```

---

## `@on.stderr`

**File:** `src/utils/on/stderr.xsh`

Register a callback for stderr output.

> **Note:** Not currently implemented — exits with code `1` if called.

---

## `@on.stdinfo`

**File:** `src/utils/on/stdinfo.xsh`

Register a callback for stdinfo (FD 3) output.

> **Note:** Not currently implemented.

---

## `@on.stdout`

**File:** `src/utils/on/stdout.xsh`

Register a callback for stdout output.

> **Note:** Not currently implemented.
