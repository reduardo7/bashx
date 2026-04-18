# Sed — `@sed`

**File:** `src/utils/sed.xsh`

```
@sed <file> <regexp>
```

Cross-platform `sed -i` wrapper that handles the macOS (`sed -i ''`) vs Linux (`sed -i`) difference automatically.

| Param | Type | Description |
|---|---|---|
| `file` | String | File to modify in-place |
| `regexp` | String | Sed substitution expression |

```bash
# Replace a value in a config file (works on both Mac and Linux)
@sed "config.ini" "s/^PORT=.*/PORT=8080/"

# Remove a line
@sed ".env" "/^DEBUG=/d"

# Insert after a match
@sed "nginx.conf" "s/listen 80;/listen 80;\n    listen 443 ssl;/"
```

> Use `@sed` instead of calling `sed` directly any time you need in-place editing — it prevents the `sed: illegal option -- i` error on macOS.
