# Arrays — `@array.*`

Array utility functions.


---

**Contents:**

- [`@array.contains`](#arraycontains)

---


## `@array.contains`

**File:** `src/utils/array/contains.xsh`

```
@array.contains <source> <search_array>*
```

Check whether a value exists in an array.

| Param | Type | Description |
|---|---|---|
| `source` | String | Value to search for |
| `search_array` | Array | Array to search in (pass as `"${arr[@]}"`) |

**Returns:** `0` if found, `1` if not found.

```bash
fruits=("apple" "banana" "cherry")

if @array.contains "banana" "${fruits[@]}"; then
  @log "Found banana"
fi

if ! @array.contains "mango" "${fruits[@]}"; then
  @log "Mango not in list"
fi
```

```bash
# Practical: validate user input against allowed values
allowed=("dev" "staging" "production")
env="$1"

if ! @array.contains "${env}" "${allowed[@]}"; then
  @app.error "Invalid environment: ${env}. Allowed: ${allowed[*]}"
fi
```
