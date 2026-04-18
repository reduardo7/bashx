# Throw / Errors — `@throw`, `@throw.*`

Structured error utilities that print a formatted message and exit.

---

## `@throw`

**File:** `src/utils/throw.xsh`

```
@throw message...
```

Print a prominent error block and exit with code `1`. Sets `BX_APP_EXIT_ILLEGAL_ERROR=true`.

```bash
@throw "Unexpected state: database is not initialized"

@throw "Required variable \$DATABASE_URL is not set"
```

Output example:
```
❌❌❌ Error! ❌❌❌
Unexpected state: database is not initialized
```

---

## `@throw.invalidParam`

**File:** `src/utils/throw/invalidParam.xsh`

```
@throw.invalidParam variable_name [note]
```

Throw an error for an invalid or missing parameter. Includes the caller's location in the error output.

| Param | Type | Description |
|---|---|---|
| `variable_name` | String | Name of the invalid variable/parameter |
| `note` | String | Optional extra context |

```bash
setup_db() {
  local host="$1"
  local port="$2"

  [ -z "${host}" ] && @throw.invalidParam host "Host cannot be empty"
  @isNumber "${port}" || @throw.invalidParam port "Must be a valid port number"
}
```

---

## `@throw.notImplemented`

**File:** `src/utils/throw/notImplemented.xsh`

```
@throw.notImplemented [note]
```

Mark a function or code path as not yet implemented. Exits with code `1`.

```bash
@Actions.migrate() {
  @throw.notImplemented "Database migration coming in v2.0"
}

@Actions.rollback() {
  @throw.notImplemented
}
```
