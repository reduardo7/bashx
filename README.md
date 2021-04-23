# BashX | Bash eXtended

## Description

- **_Bash Framework_**.
- Helps to bash scripting.
- Add common functions to help the developer.
- Compatible with _Android Shell_.
- Auto-documentation/help generation.

### Why use it

- Very easy to implement.
- No additional components required.
- No need to learn a new language.
- No need to learn a new syntax.
- Common functions and utils already implemented.
- Auto-documentation/help from source code comments.
- Solution to common _SO_ compatibility problems (`sed -i ...` on _Linux_ and `sed -i '' ...` on _Mac_).

## Quick start

You can start your project with:

```bash
./bashx _bashx init project {BASHX_VERSION} {PROJECT_PATH}
```

Where:

- `BASHX_VERSION` is a [_tag_ from this repository](https://github.com/reduardo7/bashx/tags)
- `PROJECT_PATH` is the _script name_ with _full path_.

### Examples

```bash
./bashx _bashx init project v3.0.0 my-app
```

```bash
./bashx _bashx init project v3.0.0 ~/projects/my-script.sh
```

## Manual start

**1)** Add next at beginning of the script file:

```bash
#!/usr/bin/env bash

###############################################################################
# BashX | https://github.com/reduardo7/bashx
set +ex;export BASHX_VERSION="v3.0.0"
(export LC_CTYPE=C;export LC_ALL=C;export LANG=C;set -e;x() { s="$*";echo "# Error: ${s:-Installation fail}" >&2;exit 1;};d=/dev/null;[ ! -z "$BASHX_VERSION" ] || x BASHX_VERSION is required;export BASHX_DIR="${BASHX_DIR:-${HOME:-/tmp}/.bashx/$BASHX_VERSION}";if [ ! -d "$BASHX_DIR" ];then u="https://raw.githubusercontent.com/reduardo7/bashx/$BASHX_VERSION/src/setup.sh";if type wget >$d 2>&1;then sh -c "$(wget -q $u -O -)" || x;elif type curl >$d 2>&1;then sh -c "$(curl -fsSL $u)" || x;else x wget or curl are required. Install wget or curl to continue;fi;fi) || exit $?
. "${HOME:-/tmp}/.bashx/${BASHX_VERSION}/src/init.sh"
###############################################################################
```

> See [/bashx](/bashx#L3)

**2)** Write your code.

**3)** Optionally, add next at end of the script file, to work as _cli_:

```bash
@app.run
```

### Project Example

```bash
#!/usr/bin/env bash

###############################################################################
# BashX | https://github.com/reduardo7/bashx
set +ex;export BASHX_VERSION="v3.0.0"
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

## Doc

Go to [`src/README.md`](src/README.md) documentation for more details.

### Development Documentation

Show [_Development Documentation_](src/actions/_dev-doc.xsh) using:

```bash
./bashx _dev-doc
```

### Framework Utilities

Show [_Framework Utilities Documentation_](src/actions/_bashx/README.md) using:

```bash
./bashx _bashx
```

## Global Variables

### [`BASHX_COLORS_DISABLED`](src/utils/style.xsh#L92)

Set vale to `1` to disable **BashX** output colors, disabling the `@style` function.

**Example:**

```bash
BASHX_COLORS_DISABLED=1 ./bashx
```

## Tips

### Print/Log (echo ...)

- `echo` is used for function output.
- Use `@log` to print log messages.
- Use `@log.warn` to print warning messages.

### Command log (set -x)

- Avoid usage of **BashX** _Functions_ inside of `set -x` section.

#### Command log examples

```bash
...
( set -x
  ...
  echo my test
  ...
)
...
```

```bash
...
set -x
  ...
  echo my test
  ...
set +x
...
```

### APP Exit & Error

- Use `@app.exit` to exit.
- Use `@app.error` to print an error and exit.

### Events Workflow

1. `src/events/invalid-action.xsh` is triggered if an invalid action was used.
2. `src/events/ready.xsh` is triggered on the initialization is complete.
3. `src/events/start.xsh` is triggered before a valid action is called.
4. `src/events/error.xsh` is triggered when an error has occurred.
5. `src/events/finish.xsh` is triggered on execution finished.

Valid events options constant: `BX_EVENTS_OPTS`.

## Optimizations

See: [http://tldp.org/LDP/abs/html/optimizations.html](http://tldp.org/LDP/abs/html/optimizations.html)

## Testing with Docker

```bash
docker run --rm \
  -v $(pwd):/root/.bashx/master:ro \
  -v $(pwd):/app:ro \
  -w '/app' \
  -ti ubuntu '/app/bashx'
```

```bash
docker run --rm \
  -v $(pwd):/root/.bashx/master:ro \
  -v $(pwd):/app:ro \
  -w '/app' \
  -ti debian:8 '/app/bashx'
```

## Notes

### Constants & Config Variables

All _BashX_ **constants** starts with `BX_`, and **configuration** starts with `BASHX_`.

## VIM

In order to make [_VIM_](https://www.vim.org) syntax check and code format work,
add the following line at the end of your `.xsh` file:

> `# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab`
