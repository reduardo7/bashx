# Validation — `@isBoolean`, `@isNumber`, `@isRoot`, `@rootValidate`

Simple guard functions for type and permission checks.

---

## `@isBoolean`

**File:** `src/utils/isBoolean.xsh`

```
@isBoolean var
```

Check whether a value is exactly `true` or `false`.

**Returns:** `0` if boolean, `1` otherwise.

```bash
flag="true"
if @isBoolean "${flag}"; then
  @log "Valid boolean"
fi

# Common usage: validate a parameter
setup() {
  local verbose="$1"
  @isBoolean "${verbose}" || @throw.invalidParam verbose "Must be true or false"
}
```

---

## `@isNumber`

**File:** `src/utils/isNumber.xsh`

```
@isNumber var
```

Check whether a value is a non-negative integer.

**Returns:** `0` if number, `1` otherwise.

```bash
if @isNumber "${count}"; then
  @log "Count: ${count}"
else
  @app.error "Expected a number, got: ${count}"
fi

# Validate port
@isNumber "${port}" || @throw.invalidParam port "Port must be a number"
```

---

## `@isRoot`

**File:** `src/utils/isRoot.xsh`

```
@isRoot
```

Check whether the script is running as root (`uid == 0`).

**Returns:** `0` if root, `1` otherwise.

```bash
if @isRoot; then
  @log "Running as root"
fi

if ! @isRoot; then
  @log.warn "Some features require root"
fi
```

---

## `@rootValidate`

**File:** `src/utils/rootValidate.xsh`

```
@rootValidate [message...]
```

Ensure the script is running as root, or exit with an error message.

| Param | Type | Default | Description |
|---|---|---|---|
| `message` | String | `This script must be run as root!` | Error message |

```bash
# At the top of a privileged action
@Actions.install() {
  @rootValidate
  # ... installation steps
}

@Actions.configure-system() {
  @rootValidate "The configure-system action requires root. Run with sudo."
  # ...
}
```
