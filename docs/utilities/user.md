# User Interaction — `@user.*`

TTY-aware interactive input utilities. All functions detect whether stdin is a terminal (`$BX_TTY`) and handle the non-TTY case gracefully.

---

## `@user.input`

**File:** `src/utils/user/input.xsh`

```
@user.input [msg [default [max_len [timeout [silent]]]]]
```

Prompt the user for text input and print the result to stdout.

| Param | Type | Default | Description |
|---|---|---|---|
| `msg` | String | — | Prompt message |
| `default` | String | — | Default value if user presses Enter |
| `max_len` | Integer | — | Maximum input length |
| `timeout` | Integer | — | Seconds before using default |
| `silent` | Boolean | `false` | Hide typed characters (for passwords) |

**Returns:** `0` valid input, `1` cancelled, `2` empty / used default.

```bash
# Basic input
name="$(@user.input "Enter your name:")"

# With default
env="$(@user.input "Environment:" "production")"

# Password
password="$(@user.input "Password:" "" 0 0 true)"

# With timeout (auto-accept default after 10s)
choice="$(@user.input "Continue? [yes]" "yes" 0 10)"
```

---

## `@user.confirm`

**File:** `src/utils/user/confirm.xsh`

```
@user.confirm [msg]
```

Ask a yes/no question.

| Param | Type | Default | Description |
|---|---|---|---|
| `msg` | String | `Confirm?` | Question to display |

**Returns:** `0` yes, `1` no, `254` no TTY.

```bash
if @user.confirm "Delete all files?"; then
  rm -rf ./dist
else
  @log "Cancelled"
fi

if @user.confirm "Deploy to production?"; then
  @Actions.deploy
fi
```

---

## `@user.choice`

**File:** `src/utils/user/choice.xsh`

```
@user.choice message options [default]
```

Present a set of single-character options and return the user's selection.

| Param | Type | Default | Description |
|---|---|---|---|
| `message` | String | — | Prompt message |
| `options` | String | — | Space-separated list of valid chars |
| `default` | Char | — | Default if input is empty or invalid |

```bash
answer="$(@user.choice "Select action:" "a b c" "b")"
# Displays: "Select action: (a/b/c)"

case "${answer}" in
  a) @log "Action A" ;;
  b) @log "Action B" ;;
  c) @log "Action C" ;;
esac
```

```bash
env="$(@user.choice "Deploy to:" "d s p" "d")"
case "${env}" in
  d) target="development" ;;
  s) target="staging" ;;
  p) target="production" ;;
esac
```

---

## `@user.pause`

**File:** `src/utils/user/pause.xsh`

```
@user.pause [message...]
```

Wait for any key press before continuing. Skips gracefully when not at a TTY.

```bash
@log.title "Review output above"
@user.pause "Press any key to continue..."

@log.title "Cleaning up"
@user.pause
```

---

## `@user.timeout`

**File:** `src/utils/user/timeout.xsh`

```
@user.timeout timeout cmd [message]
```

Show a countdown and execute `cmd` when it reaches zero. The user can cancel with `C` or `ESC`.

| Param | Type | Default | Description |
|---|---|---|---|
| `timeout` | Integer | — | Countdown seconds (should be > 1) |
| `cmd` | String | — | Command to execute when countdown ends |
| `message` | String | `Count down` | Display label |

**Returns:** command exit code, or `255` if cancelled.

```bash
# Auto-reboot after 10 seconds unless cancelled
@user.timeout 10 "sudo reboot" "Rebooting in"

# Auto-deploy unless user cancels
@user.timeout 5 "@Actions.deploy" "Deploying to production in"
if [[ $? -eq 255 ]]; then
  @log "Deployment cancelled"
fi
```
