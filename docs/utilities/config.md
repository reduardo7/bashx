# Configuration — `@config.*`

Configuration file utilities.


---

**Contents:**

- [`@config.test`](#configtest)

---


## `@config.test`

**File:** `src/utils/config/test.xsh`

```
@config.test <config_file> <fail_on_error?>
```

Validate a configuration file by sourcing it in a subshell and checking for syntax errors.

| Param | Type | Default | Description |
|---|---|---|---|
| `config_file` | String | — | Path to the config file |
| `fail_on_error` | Boolean | `true` | Exit the script if the config is invalid |

**Returns:** `0` if valid, `1` on error.

```bash
# Validate before loading
@config.test ".env"

# Non-fatal check
if ! @config.test ".env.local" false; then
  @log.warn "Local config has errors — using defaults"
fi

# Validate in a pre-flight check action
@Actions.check-config() {
  @config.test "${BASHX_APP_CONFIG_FILE}"
  @log "Config OK"
}
```
