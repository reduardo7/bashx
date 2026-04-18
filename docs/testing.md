# Testing — `@@assert.*`

BashX includes a built-in assertion framework for writing unit tests. Tests are plain `.xsh` files placed under `src/tests/` (or your project's `tests/` directory).


---

**Contents:**

- [`Setup`](#setup)
- [`Running Tests`](#running-tests)
- [`Assertions`](#assertions)
  - [`@@assert.fail`](#assertfail)
  - [`@@assert.warn`](#assertwarn)
  - [`@@assert.true` / `@@assert.false`](#asserttrue-assertfalse)
  - [`@@assert.empty` / `@@assert.notEmpty`](#assertempty-assertnotempty)
  - [`@@assert.number`](#assertnumber)
  - [`@@assert.errorCode` / `@@assert.notErrorCode`](#asserterrorcode-assertnoterrorcode)
  - [`@@assert.equal` / `@@assert.notEqual`](#assertequal-assertnotequal)
  - [`@@assert.contains` / `@@assert.notContains`](#assertcontains-assertnotcontains)
  - [`@@assert.startWith` / `@@assert.endWith`](#assertstartwith-assertendwith)
  - [`@@assert.regExp`](#assertregexp)
  - [`@@assert.stdOut` / `@@assert.noStdOut`](#assertstdout-assertnostdout)
  - [`@@assert.errOut` / `@@assert.noErrOut`](#asserterrout-assertnoerrout)
  - [`@@assert.noOut`](#assertnoout)
  - [`@@assert.exec`](#assertexec)
- [`Example Test File`](#example-test-file)
- [`Example: Testing a Custom Function`](#example-testing-a-custom-function)

---


## Setup

Load the assertion framework at the top of a test file:

```bash
@asserts.load
```

Tests exit with code `0` on success. Any failed assertion calls `exit 1` immediately.

---

## Running Tests

```bash
# Run all tests
./bashx _run-tests

# Run specific test files (name without .xsh)
./bashx _run-tests str.trim array

# Run in Docker
./bashx _run-tests-docker
```

---

## Assertions

### `@@assert.fail`

Force a test failure with a message.

```bash
@@assert.fail "This code path should not be reached"
```

---

### `@@assert.warn`

Emit a warning without failing the test.

```bash
@@assert.warn "This feature is deprecated"
```

---

### `@@assert.true` / `@@assert.false`

```bash
@@assert.true true
@@assert.false false

flag="$(@isBoolean "hello" && echo true || echo false)"
@@assert.false "${flag}"
```

---

### `@@assert.empty` / `@@assert.notEmpty`

```bash
result=""
@@assert.empty "${result}"

result="hello"
@@assert.notEmpty "${result}"
```

---

### `@@assert.number`

```bash
@@assert.number 42
@@assert.number 0
```

---

### `@@assert.errorCode` / `@@assert.notErrorCode`

```bash
@@assert.errorCode 1
@@assert.errorCode 127

@@assert.notErrorCode 0
```

---

### `@@assert.equal` / `@@assert.notEqual`

```bash
result="$(@str.toLower "HELLO")"
@@assert.equal "hello" "${result}"

@@assert.notEqual "foo" "bar"
```

---

### `@@assert.contains` / `@@assert.notContains`

```bash
@@assert.contains "hello world" "world"
@@assert.notContains "hello world" "python"
```

---

### `@@assert.startWith` / `@@assert.endWith`

```bash
@@assert.startWith "hello world" "hello"
@@assert.endWith "hello world" "world"
```

---

### `@@assert.regExp`

```bash
@@assert.regExp "^[0-9]+$" "12345"
@@assert.regExp "^v[0-9]+\.[0-9]+" "v3.2.0"
```

---

### `@@assert.stdOut` / `@@assert.noStdOut`

Assert whether a command produces stdout.

```bash
@@assert.stdOut "@now.date"
@@assert.noStdOut "@log 'no stdout here'"
```

---

### `@@assert.errOut` / `@@assert.noErrOut`

Assert whether a command produces stderr.

```bash
@@assert.errOut "@log.warn 'this goes to stderr'"
@@assert.noErrOut "@log 'info only'"
```

---

### `@@assert.noOut`

Assert that a command produces no output at all (neither stdout nor stderr).

```bash
@@assert.noOut "@function.void"
```

---

### `@@assert.exec`

```
@@assert.exec <fn_name> <expected_exit> <params?>
```

Execute a function and assert its exit code. `expected_exit` can be:

- An integer (exact match)
- `true` — assert exit code is `0`
- `false` — assert exit code is non-zero

| Param           | Type               | Description                                 |
| --------------- | ------------------ | ------------------------------------------- |
| `fn_name`       | String             | Function name to call                       |
| `expected_exit` | Integer or Boolean | Expected exit code                          |
| `params`        | String             | Arguments passed to the function (optional) |

```bash
@@assert.exec "@isNumber" true "42"
@@assert.exec "@isNumber" false "hello"

@@assert.exec "@array.contains" true '"banana" "apple" "banana" "cherry"'
@@assert.exec "@array.contains" false '"mango" "apple" "banana"'

@@assert.exec "@isRoot" false
```

---

## Example Test File

**File:** `src/tests/str.trim.xsh`

```bash
@asserts.load

# Basic trim
result="$(@str.trim "  hello  ")"
@@assert.equal "hello" "${result}"

# Custom character
result="$(@str.trim "###title###" "#")"
@@assert.equal "title" "${result}"

# Already trimmed
result="$(@str.trim "clean")"
@@assert.equal "clean" "${result}"

# Empty string
result="$(@str.trim "")"
@@assert.empty "${result}"
```

---

## Example: Testing a Custom Function

**File:** `src/tests/my-action.xsh`

```bash
@asserts.load

# Load the action manually if testing outside the full app
. "${BASHX_UTILS_PATH}/../actions/my-action.xsh"

# Test expected success
@@assert.exec "@Actions.my-action" true "--flag value"

# Test expected failure
@@assert.exec "@Actions.my-action" false "--invalid-flag"
```
