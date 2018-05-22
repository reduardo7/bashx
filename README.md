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
./new-project.sh BASHX_VERSION PROJECT_NAME
```

Where:

- `BASHX_VERSION` is a [_tag_ from this repository](https://github.com/reduardo7/bashx/tags)
- `PROJECT_NAME` is the _script name_ with _full path_.

### Examples

```bash
./new-project.sh 1.0 my-app
./new-project.sh 2.1 ~/projects/my-script.sh
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
        |   +-> start.sh           #     Optional. Triggered on start.
        |   |                      #
        |   +-> error.sh           #     Optional. Triggered on error (exit code != 0).
        |   |                      #
        |   +-> exit.sh            #     Optional. Triggered on exit.
        |                          #
        +-> resources/             # Optional. Resources files.
            |                      #
            +-> [resource].[ext]   #     Resource file...
            |                      #
            +-> *                  #     Resource file...
```

Valid events options: `EVENTS_OPTS`.

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
2. `src/events/start.sh` is triggered before a valid action is called.
3. `src/events/error.sh` is triggered when an error has occurred.
4. `src/events/exit.sh` is triggered before script has finished.

## Optimizations

See: [http://tldp.org/LDP/abs/html/optimizations.html](http://tldp.org/LDP/abs/html/optimizations.html)
