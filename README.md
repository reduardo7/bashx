# BashX | Bash eXtended

## Description

- **_Bash Framework_**.
- Helps to bash scripting.
- Add common functions to help the developer.
- Compatible with _Android Shell_.
- Auto-documentation/help generation.

### Why use it

- Very easy to implement.
- No additionals components required.
- No need to learn a new language.
- No need to learn a new syntax.
- Common functions and utils already implemented.
- Auto-documentation/help from source code comments.

## Quick start

You can start your project with:

```bash
./demo _bashx init-project {BASHX_VERSION} {PROJECT_PATH}
```

Where:

- `BASHX_VERSION` is a [_tag_ from this repository](https://github.com/reduardo7/bashx/tags)
- `PROJECT_PATH` is the _script name_ with _full path_.

### Examples

```bash
./demo _bashx init-project 1.0 my-app
```

```bash
./demo _bashx init-project 1.2 ~/projects/my-script.sh
```

#### Project Structure

```text
--> project-directory-name         # Optional. Container directory.
    |                              #
    +-> my-script-name             # Required. Main script.
    |                              #
    +-> .my-script-name.env        # Optional. Config file.
    |                              #
    +-> my-script-name.src/        # Optional. Sources.
        |                          #
        +-> actions/               # Optional. Actions scripts.
        |   |                      #
        |   +-> [action-name].sh   #    Test script example...
        |   |                      #
        |   +-> *                  #    Test script example...
        |                          #
        +-> tests/                 # Optional. Test scripts.
        |   |                      #
        |   +-> [test-name].sh     #     Test script example...
        |   |                      #
        |   +-> *                  #     Test script example...
        |                          #
        +-> utils/                 # Optional. Utils scripts.
        |   |                      #
        |   +-> [util-name].sh     #     Test script example...
        |   |                      #
        |   +-> *                  #     Test script example...
        |                          #
        +-> events/                # Optional. Events scripts. Executed in next order:
        |   |                      #
        |   +-> invalid-action.sh  #     Optional. Triggered on invalid action called.
        |   |                      #
        |   +-> ready.sh           #     Optional. Triggered on ready.
        |   |                      #
        |   +-> start.sh           #     Optional. Triggered on start the selected action.
        |   |                      #
        |   +-> error.sh           #     Optional. Triggered on error (exit code != 0).
        |   |                      #
        |   +-> finish.sh          #     Optional. Triggered on execution finished.
        |                          #
        +-> resources/             # Optional. Resources files.
            |                      #
            +-> [resource].[ext]   #     Resource file...
            |                      #
            +-> *                  #     Resource file...
```

Valid events options constant: `EVENTS_OPTS`.

## Doc

### Development Documentation

Show _Development Documentation_ using:

```bash
./demo _dev-doc
```

### Framework Utilities

```bash
./demo _bashx
```

## Global Variables

### `BASHX_COLORS_DISABLED`

Set vale to `1` to diable **BashX** output colors, disabling the `@style` function.

**Example:**

```bash
BASHX_COLORS_DISABLED=1 ./demo
```

## Tips

### Print/Log (echo ...)

- `echo` is used for function output.
- Use `@print` to print log messages.
- Use `@warn` to print warning messages.

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

### APP Exit && Error

- Use `@exit`, `@die` or `@end` to exit.
- Use `@error` to print an error and exit.

### Events Workflow

1. `src/events/invalid-action.sh` is triggered if an invalid action was used.
2. `src/events/ready.sh` is triggered on the initialization is complete.
3. `src/events/start.sh` is triggered before a valid action is called.
4. `src/events/error.sh` is triggered when an error has occurred.
5. `src/events/finish.sh` is triggered on execution finished.

Valid events options constant: `EVENTS_OPTS`.

## Optimizations

See: [http://tldp.org/LDP/abs/html/optimizations.html](http://tldp.org/LDP/abs/html/optimizations.html)
