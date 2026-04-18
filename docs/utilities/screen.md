# Screen — `@screen.*`

Terminal dimension utilities.

---

## `@screen.width`

**File:** `src/utils/screen/width.xsh`

```
@screen.width [default_width]
```

Return the terminal width in columns. Falls back to `default_width` if `tput` is not available.

| Param | Type | Description |
|---|---|---|
| `default_width` | Integer | Fallback width when `tput` is unavailable |

```bash
width="$(@screen.width)"
width="$(@screen.width 80)"

# Draw a full-width separator
@log "$(@str.repeat ${width} "-")"

# Pad output to terminal width
padding=$(( $(@screen.width 80) - $(@str.len "${label}") ))
```

> `BASHX_APP_WIDTH` is set at startup using `@screen.width` and is used as the default by `@log.line` and similar utilities.
