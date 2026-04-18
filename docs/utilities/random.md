# Random — `@random`

**File:** `src/utils/random.xsh`

```
@random <len?>
```

Generate a random alphanumeric string from `/dev/urandom`.

| Param | Type | Default | Description |
|---|---|---|---|
| `len` | Integer | `10` | Length of the output string |

```bash
# Default 10-character token
token="$(@random)"

# Custom length
secret="$(@random 32)"

# Unique filenames
tmpname="$(@random 8)"
outfile="/tmp/job-${tmpname}.log"

# Session ID
session_id="$(@random 24)"
@log "Session: ${session_id}"
```
