# App Management — `@app.*`

Core application lifecycle utilities.

---

## `@app.run`

**File:** `src/utils/app/run.xsh`

Main application entry point. Reads `BX_SCRIPT_ARGS[0]` as the action name, fires lifecycle events (`ready` → `start` → `error` → `finish`), and dispatches to the matching `@Actions.<name>` function.

Call this at the end of your main script after defining all actions:

```bash
@Actions.greet() {
  @log "Hello, world!"
}

@app.run
```

---

## `@app.exit`

**File:** `src/utils/app/exit.xsh`

```
@app.exit [code]
```

Exit the application cleanly. Fires the `finish` event, runs any `@on.exit` callbacks, and removes the temp directory. Use this instead of bare `exit`.

| Param | Type | Default | Description |
|---|---|---|---|
| `code` | Integer | `0` | Exit code |

```bash
# Exit with success
@app.exit

# Exit with error
@app.exit 1
```

> **Warning:** Avoid calling from a subshell — use `@app.error` or `@throw` instead.

---

## `@app.error`

**File:** `src/utils/app/error.xsh`

```
@app.error msg [print_backtrace [code]]
```

Print an error message to stderr and exit.

| Param | Type | Default | Description |
|---|---|---|---|
| `msg` | String | — | Error message |
| `print_backtrace` | Boolean | `false` | Print call backtrace |
| `code` | Integer | `1` | Exit code |

```bash
@app.error "Something went wrong"
@app.error "Fatal: missing config" true 2
```

---

## `@app.backtrace`

**File:** `src/utils/app/backtrace.xsh`

Print the current call stack.

```bash
@log "$(@app.backtrace)"
```

---

## `@app.info`

**File:** `src/utils/app/info.xsh`

Print the application title and version (`BASHX_APP_TITLE v BASHX_APP_VERSION`).

```bash
@app.info
# Output: My App v1.0.0
```
