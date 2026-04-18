# Functions — `@function.*`

Function introspection and dynamic loading utilities.


---

**Contents:**

- [`@function.exists`](#functionexists)
- [`@function.load`](#functionload)
- [`@function.void`](#functionvoid)

---


## `@function.exists`

**File:** `src/utils/function/exists.xsh`

```
@function.exists <func_name>
```

Check whether a function is defined in the current shell.

**Returns:** `0` if exists, `1` if not.

```bash
if @function.exists "@Actions.deploy"; then
  @Actions.deploy
else
  @log.warn "deploy action not defined"
fi

# Guard against optional overrides
if @function.exists "custom_hook"; then
  custom_hook
fi
```

---

## `@function.load`

**File:** `src/utils/function/load.xsh`

```
@function.load <functions_path> <prefix?>
```

Scan a directory for `.xsh` files and create lazy-loading stub functions. Each stub sources its `.xsh` file on first call.

| Param | Type | Default | Description |
|---|---|---|---|
| `functions_path` | String | — | Directory containing `.xsh` files |
| `prefix` | String | directory name | Function name prefix |

This is called automatically by `src/init.sh` for `src/utils/` and `src/actions/`. You only need it when loading custom utility directories.

```bash
# Load custom utilities from your project
@function.load "${MY_APP_SRC}/utils" "@"

# Load with a custom prefix
@function.load "${MY_APP_SRC}/helpers" "@helpers"
```

---

## `@function.void`

**File:** `src/utils/function/void.xsh`

A no-op placeholder (alias for `:`). Use it to define an empty function body without leaving a truly empty function.

```bash
# In an event file you don't need yet:
@function.void

# Or to satisfy a required callback hook
on_finish() {
  @function.void
}
```
