# Logging — `@log`, `@log.*`

Output utilities. All logging goes to **stdinfo** (file descriptor 3) unless noted otherwise, keeping stdout clean for data return values.

---

## `@log`

**File:** `src/utils/log.xsh`

```
@log <text?>*
```

Print a message to stdinfo (FD 3). Supports ANSI style codes via `@style`.

```bash
@log "Build complete"
@log "Status: $(@style color:green)OK$(@style)"
```

---

## `@log.warn`

**File:** `src/utils/log/warn.xsh`

```
@log.warn <text?>*
```

Print to stderr. Use for warnings that should not be lost in pipelines.

```bash
@log.warn "Skipping missing config file"
```

---

## `@log.alert`

**File:** `src/utils/log/alert.xsh`

```
@log.alert <text?>*
```

Print a red-colored message to stderr.

```bash
@log.alert "Deployment failed!"
```

---

## `@log.title`

**File:** `src/utils/log/title.xsh`

```
@log.title <text?>*
```

Print a decorated title block with borders.

```bash
@log.title "Deployment Pipeline"
# Output:
# ===========================
# = Deployment Pipeline =
# ===========================
```

---

## `@log.line`

**File:** `src/utils/log/line.xsh`

```
@log.line <len?> <str?> <prefix?> <suffix?>
```

Print a horizontal rule.

| Param | Type | Default | Description |
|---|---|---|---|
| `len` | Integer | `$BASHX_APP_WIDTH` | Line length |
| `str` | String | `=` | Character to repeat |
| `prefix` | String | — | Prefix text |
| `suffix` | String | — | Suffix text |

```bash
@log.line
@log.line 40
@log.line 40 "-"
@log.line 40 "-" "-- " " --"
```

---

## `@log.cmd`

**File:** `src/utils/log/cmd.xsh`

```
@log.cmd <command>*
```

Print a command, execute it, then print its exit code. Useful for scripted CI output.

```bash
@log.cmd docker build -t myapp .
@log.cmd npm test
```

---

## `@log.time`

**File:** `src/utils/log/time.xsh`

```
@log.time <text?>*
```

Print a timestamped log entry with caller location.

```bash
@log.time "Starting migration"
# Output: ¬ 2024-01-15.12:34:56.123 | script.xsh:42 > Starting migration
```

---

## `@log.rewrite`

**File:** `src/utils/log/rewrite.xsh`

```
@log.rewrite <text> <lines?>
```

Move the cursor back `lines` rows and overwrite with `text`. Useful for progress indicators.

| Param | Type | Default | Description |
|---|---|---|---|
| `text` | String | — | New text to print |
| `lines` | Integer | `1` | Lines to move back |

```bash
@log "Processing..."
sleep 1
@log.rewrite "Processing... done!"
```

---

## `@log.waiting`

**File:** `src/utils/log/waiting.xsh`

```
@log.waiting <timeout> <message?>
```

Print a message every 0.25 seconds until `timeout` seconds pass.

| Param | Type | Default | Description |
|---|---|---|---|
| `timeout` | Integer | — | Duration in seconds |
| `message` | String | `Please wait...` | Message to repeat |

```bash
@log.waiting 5 "Waiting for service to start"
```
