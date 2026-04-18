# Now / Date-Time — `@now.*`

Current date and time utilities.


---

**Contents:**

- [`@now.date`](#nowdate)
- [`@now.time`](#nowtime)
- [`@now.dateTime`](#nowdatetime)

---


## `@now.date`

**File:** `src/utils/now/date.xsh`

Return the current date in `YYYY-MM-DD` format.

```bash
today="$(@now.date)"
@log "Today is: ${today}"
# Output: Today is: 2024-01-15

backup_file="backup-$(@now.date).tar.gz"
```

---

## `@now.time`

**File:** `src/utils/now/time.xsh`

Return the current time in `HH:MM:SS` format.

```bash
@log "Started at: $(@now.time)"
# Output: Started at: 14:30:05
```

---

## `@now.dateTime`

**File:** `src/utils/now/dateTime.xsh`

Return the current date and time in `YYYY-MM-DD HH:MM:SS` format.

```bash
@log "Timestamp: $(@now.dateTime)"
# Output: Timestamp: 2024-01-15 14:30:05

logfile="deploy-$(@now.dateTime | tr ' ' '_' | tr ':' '-').log"
# logfile = "deploy-2024-01-15_14-30-05.log"
```
