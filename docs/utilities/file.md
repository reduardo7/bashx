# Files — `@file.*`

File and path utilities.

---

## `@file.name`

**File:** `src/utils/file/name.xsh`

```
@file.name file [remove_extension]
```

Return the base name of a file path.

| Param | Type | Default | Description |
|---|---|---|---|
| `file` | String | — | File path |
| `remove_extension` | Boolean | `false` | Strip the extension |

```bash
name="$(@file.name "/path/to/script.sh")"
# name = "script.sh"

name="$(@file.name "/path/to/script.sh" true)"
# name = "script"

name="$(@file.name "/etc/nginx/nginx.conf" true)"
# name = "nginx"
```

---

## `@file.contains`

**File:** `src/utils/file/contains.xsh`

```
@file.contains text file
```

Check if a file contains a given string.

**Returns:** `0` if found, `1` if not.

```bash
if @file.contains "DATABASE_URL" ".env"; then
  @log "Config found"
fi

if ! @file.contains "AllowOverride All" "/etc/apache2/apache2.conf"; then
  @log.warn "AllowOverride not set"
fi
```

---

## `@file.ensureLineExists`

**File:** `src/utils/file/ensureLineExists.xsh`

```
@file.ensureLineExists file line [sudo]
```

Add a line to a file if it does not already exist.

| Param | Type | Default | Description |
|---|---|---|---|
| `file` | String | — | Target file |
| `line` | String | — | Line to add |
| `sudo` | Boolean | `false` | Use sudo to write |

**Returns:** `0` line added, `1` already exists, `2` error.

```bash
# Add to /etc/hosts if missing
@file.ensureLineExists "/etc/hosts" "127.0.0.1 myapp.local" true

# Add environment variable to profile
@file.ensureLineExists "${HOME}/.bashrc" 'export PATH="$HOME/.local/bin:$PATH"'

result=$?
if [[ ${result} -eq 0 ]]; then
  @log "Line added"
elif [[ ${result} -eq 1 ]]; then
  @log "Line already present"
fi
```
