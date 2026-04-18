# Sudo — `@sudo`

**File:** `src/utils/sudo.xsh`

```
@sudo <path> <command>
```

Run `command` with `sudo` only if `path` is not writable by the current user. Avoids unnecessary privilege escalation.

| Param | Type | Description |
|---|---|---|
| `path` | String | Path to check for write permission |
| `command` | String | Command to execute |

```bash
# Install a binary — uses sudo only if /usr/local/bin is not writable
@sudo "/usr/local/bin" "cp ./myapp /usr/local/bin/myapp"

# Write a config file — uses sudo only if /etc/myapp is not writable
@sudo "/etc/myapp" "cp ./myapp.conf /etc/myapp/myapp.conf"

# Create a directory — escalates only when needed
@sudo "/opt" "mkdir -p /opt/myapp/data"
```
