# Error Checking — `@checkError`, `@checkErrorEnd`

Lightweight exit-code guards.

---

## `@checkError`

**File:** `src/utils/checkError.xsh`

```
@checkError code [cmd]
```

If `code` is non-zero, optionally run `cmd` before continuing.

| Param | Type | Description |
|---|---|---|
| `code` | Integer | Exit code to check |
| `cmd` | String | Command to run on error (optional) |

```bash
make build
@checkError $? "@log.warn 'Build had errors'"

rsync -av ./src/ user@host:/app/
@checkError $? "@log.alert 'Sync failed'"
```

---

## `@checkErrorEnd`

**File:** `src/utils/checkErrorEnd.xsh`

```
@checkErrorEnd code [message]
```

If `code` is non-zero, call `@app.error` with `message` and exit.

| Param | Type | Description |
|---|---|---|
| `code` | Integer | Exit code to check |
| `message` | String | Error message to display on failure (optional) |

```bash
./configure
@checkErrorEnd $? "Configure step failed"

make
@checkErrorEnd $? "Build failed"

make install
@checkErrorEnd $? "Install failed"
```
