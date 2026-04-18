# Wait — `@wait.*`

Polling and waiting utilities.

---

## `@wait.until`

**File:** `src/utils/wait/until.xsh`

```
@wait.until <command> <interval?> <timeout?> <message?> <retries?> <debug?>
```

Repeatedly run `command` until it exits `0`, or until a timeout or retry limit is reached.

| Param | Type | Default | Description |
|---|---|---|---|
| `command` | String | — | Command to poll |
| `interval` | Number | `1` | Seconds between attempts |
| `timeout` | Integer | `0` | Max seconds to wait (0 = unlimited) |
| `message` | String | — | Message shown while waiting. `false` = silent |
| `retries` | Integer | `0` | Max attempts (0 = unlimited) |
| `debug` | Boolean | `false` | Show command output on each attempt |

**Returns:** `0` success, `1` retry limit reached, `2` timeout reached.

```bash
# Wait for a service to be ready
@wait.until "curl -sf http://localhost:8080/health"

# With timeout and custom message
@wait.until "pg_isready -h localhost" 2 60 "Waiting for Postgres"

# With retry limit
@wait.until "docker inspect -f '{{.State.Running}}' mycontainer | grep true" 1 0 "Starting container" 30

# Handle timeout
@wait.until "check_service" 1 30 "Waiting for service"
result=$?
if [[ ${result} -eq 2 ]]; then
  @app.error "Service did not start within 30 seconds"
fi
```

---

## `@wait.untilExists`

**File:** `src/utils/wait/untilExists.xsh`

```
@wait.untilExists <type> <path> <timeout?> <show_message?>
```

Wait until a file or directory exists.

| Param | Type | Description |
|---|---|---|
| `type` | Char | `f` = file, `d` = directory |
| `path` | String | Path to watch |
| `timeout` | Integer | Max seconds (0 = unlimited) |
| `show_message` | Boolean | Show waiting message (default `true`) |

**Returns:** `0` if exists, `1` if not found within timeout.

```bash
# Wait for a file
@wait.untilExists f "/tmp/job-done.flag"

# Wait for a directory with timeout
@wait.untilExists d "/mnt/data" 30

# Silent wait for a pid file
@wait.untilExists f "/var/run/myapp.pid" 60 false

# Check result
@wait.untilExists f "/tmp/output.json" 10
if [[ $? -ne 0 ]]; then
  @app.error "Output file was not created in time"
fi
```
