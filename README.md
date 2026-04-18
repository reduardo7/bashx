# BashX | Bash eXtended

A convention-based Bash framework that turns `.xsh` files into `@`-prefixed functions with auto-generated CLI help. No compile step — everything is sourced at runtime.

## Description

- **_Bash Framework_** — 120+ ready-to-use utility functions.
- Compatible with _Linux_, _macOS_, and _Android Shell_.
- Lazy-loads functions on first call — no startup cost for unused utilities.
- Auto-generates CLI help and usage from source comments.
- Solves cross-platform shell quirks (e.g. `sed -i` on Linux vs. macOS). See [`@sed`](src/utils/sed.xsh)

### Why use it

- No new language or syntax to learn — it's just Bash.
- No additional runtime dependencies.
- Rich stdlib: strings, logging, user input, file I/O, date/time, testing, and more.
- Drop-in help generation from `##` doc comments in source.

## Quick Start

Scaffold a new project with a single command:

```bash
./bashx _bashx init project {BASHX_VERSION} {PROJECT_PATH}
```

- `BASHX_VERSION` — a [tag from this repository](https://github.com/reduardo7/bashx/tags)
- `PROJECT_PATH` — script name or full path

**Examples:**

```bash
./bashx _bashx init project v3.2.0 my-app
./bashx _bashx init project v3.2.0 ~/projects/my-script.sh
```

## Manual Start

**1)** Add the following bootstrap block at the top of your script:

```bash
#!/usr/bin/env bash

###############################################################################
# BashX | https://github.com/reduardo7/bashx
set +ex;export BASHX_VERSION="v3.2.0"
(export LC_CTYPE=C;export LC_ALL=C;export LANG=C;set -e;x() { s="$*";echo "# Error: ${s:-Installation fail}" >&2;exit 1;};d=/dev/null;[ ! -z "$BASHX_VERSION" ] || x BASHX_VERSION is required;export BASHX_DIR="${BASHX_DIR:-${HOME:-/tmp}/.bashx/$BASHX_VERSION}";if [ ! -d "$BASHX_DIR" ];then u="https://raw.githubusercontent.com/reduardo7/bashx/$BASHX_VERSION/src/setup.sh";if type wget >$d 2>&1;then sh -c "$(wget -q $u -O -)" || x;elif type curl >$d 2>&1;then sh -c "$(curl -fsSL $u)" || x;else x wget or curl are required. Install wget or curl to continue;fi;fi) || exit $?
. "${HOME:-/tmp}/.bashx/${BASHX_VERSION}/src/init.sh"
###############################################################################
```

> See [/bashx](/bashx#L3)

**2)** Write your code.

**3)** Optionally, add the following at the end to expose actions as a CLI:

```bash
@app.run
```

### Project Example

```bash
#!/usr/bin/env bash

###############################################################################
# BashX | https://github.com/reduardo7/bashx
set +ex;export BASHX_VERSION="v3.2.0"
(export LC_CTYPE=C;export LC_ALL=C;export LANG=C;set -e;x() { s="$*";echo "# Error: ${s:-Installation fail}" >&2;exit 1;};d=/dev/null;[ ! -z "$BASHX_VERSION" ] || x BASHX_VERSION is required;export BASHX_DIR="${BASHX_DIR:-${HOME:-/tmp}/.bashx/$BASHX_VERSION}";if [ ! -d "$BASHX_DIR" ];then u="https://raw.githubusercontent.com/reduardo7/bashx/$BASHX_VERSION/src/setup.sh";if type wget >$d 2>&1;then sh -c "$(wget -q $u -O -)" || x;elif type curl >$d 2>&1;then sh -c "$(curl -fsSL $u)" || x;else x wget or curl are required. Install wget or curl to continue;fi;fi) || exit $?
. "${HOME:-/tmp}/.bashx/${BASHX_VERSION}/src/init.sh"
###############################################################################

@Actions.action1() { # \\n Action without arguments
  @log "
  Action 1
  Multi-Line
"
}

@Actions.action2() { # param1 [param2] \\n Action with arguments\\n\\tdescription second line\\nother line
  local param1="$1"
  local param2="$2"
  [ "$param1" != 'asd' ] && @throw.invalidParam param1

  @log Action 2
  @log Param1: $1
  @log Param2: $2
}

@app.run
```

#### Project Structure

```text
--> project-directory-name          # Optional. Container directory.
    |                               #
    +-> my-script-name              # Required. Main script.
    |                               #
    +-> .my-script-name.env         # Optional. Config file.
    |                               #
    +-> my-script-name.src/         # Optional. Sources.
        |                           #
        +-> actions/                # Optional. Actions scripts.
        |   |                       #
        |   +-> [group...]          #    Script group. Can be multi-level.
        |   |   |                   #
        |   |   +-> [name].xsh      #      Test script into group example... (Use with @group.name)
        |   |                       #
        |   +-> [action-name].xsh   #    Test script example...
        |   |                       #
        |   +-> *                   #    Test script example...
        |                           #
        +-> tests/                  # Optional. Test scripts.
        |   |                       #
        |   +-> [test-name].xsh     #     Test script example...
        |   |                       #
        |   +-> *                   #     Test script example...
        |                           #
        +-> utils/                  # Optional. Utils scripts.
        |   |                       #
        |   +-> [util-name].xsh     #     Test script example...
        |   |                       #
        |   +-> *                   #     Test script example...
        |                           #
        +-> events/                 # Optional. Events scripts. Executed in next order:
        |   |                       #
        |   +-> invalid-action.xsh  #     Optional. Triggered on invalid action called.
        |   |                       #
        |   +-> ready.xsh           #     Optional. Triggered on ready.
        |   |                       #
        |   +-> start.xsh           #     Optional. Triggered on start the selected action.
        |   |                       #
        |   +-> error.xsh           #     Optional. Triggered on error (exit code != 0).
        |   |                       #
        |   +-> finish.xsh          #     Optional. Triggered on execution finished.
        |                           #
        +-> resources/              # Optional. Resources files.
            |                       #
            +-> [resource].[ext]    #     Resource file...
            |                       #
            +-> *                   #     Resource file...
```

Valid events options constant: `BX_EVENTS_OPTS`.

## Documentation

| Reference                              | Description                                 |
| -------------------------------------- | ------------------------------------------- |
| **[docs/](docs/README.md)**            | Full utility, action, and testing reference |
| **[docs/testing.md](docs/testing.md)** | `@@assert.*` testing framework              |
| **[docs/actions.md](docs/actions.md)** | Public and framework actions                |
| **[src/README.md](src/README.md)**     | Source directory structure                  |

### Development Documentation

Print inline development docs:

```bash
./bashx _dev-doc
```

### Framework Utilities

List BashX scaffolding commands:

```bash
./bashx _bashx
```

## Global Variables

### [`BASHX_COLORS_DISABLED`](src/utils/style.xsh#L92)

Set to `1` to disable all **BashX** output colors (`@style` becomes a no-op).

```bash
BASHX_COLORS_DISABLED=1 ./bashx
```

## Tips

### Output

- `echo` is reserved for function return values (stdout is treated as data).
- Use `@log` for informational messages, `@log.warn` for warnings, `@log.alert` for alerts.

### Exit & Error

- Use `@app.exit` to exit cleanly.
- Use `@app.error` to print an error message and exit with a non-zero code.

### `set -x` (command tracing)

Avoid calling `@`-functions inside `set -x` blocks — the DEBUG trap interacts badly with nested functions.

```bash
( set -x
  echo my test   # plain commands only
)
```

```bash
set -x
  echo my test
set +x
```

### Events Workflow

Events fire in this order:

1. `invalid-action.xsh` — triggered if an unrecognised action was called.
2. `ready.xsh` — triggered when initialisation is complete.
3. `start.xsh` — triggered before a valid action runs.
4. `error.xsh` — triggered when an error occurs (exit code ≠ 0).
5. `finish.xsh` — triggered after execution finishes.

Constant for valid event names: `BX_EVENTS_OPTS`.

## Testing with Docker

Run the test suite inside a container (mirrors CI):

```bash
./bashx _run-tests-docker          # ubuntu + debian:8
./bashx _run-tests-all             # Docker + local
```

Or run a container manually:

```bash
docker run --rm \
  -v $(pwd):/root/.bashx/master:ro \
  -v $(pwd):/app:ro \
  -w '/app' \
  -ti ubuntu '/app/bashx'
```

## Notes

### VIM

Add this modeline at the end of every `.xsh` file for correct syntax highlighting and formatting:

```plain
# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
```

### Constants & Config Variables

| Prefix    | Purpose                                                       |
| --------- | ------------------------------------------------------------- |
| `BX_*`    | Readonly internal framework constants (do not assign)         |
| `BASHX_*` | User-configurable settings (set in `.env` or before sourcing) |
