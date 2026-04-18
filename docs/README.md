# BashX Documentation

Complete reference for all BashX utilities and actions.

## Utilities

| Category | Description |
|---|---|
| [App Management](utilities/app.md) | `@app.*` — exit, error, info, backtrace, run |
| [Argument Parsing](utilities/args.md) | `@args` — parse CLI flags and options |
| [Arrays](utilities/array.md) | `@array.*` — array operations |
| [Code](utilities/code.md) | `@code.*` — script minification, variable cleaning |
| [Configuration](utilities/config.md) | `@config.*` — validate config files |
| [Error Checking](utilities/check-error.md) | `@checkError`, `@checkErrorEnd` |
| [Files](utilities/file.md) | `@file.*` — file operations |
| [Functions](utilities/function.md) | `@function.*` — function introspection and loading |
| [Logging](utilities/log.md) | `@log`, `@log.*` — output, warnings, titles, timers |
| [Now / Date-Time](utilities/now.md) | `@now.*` — current date and time |
| [On / Callbacks](utilities/on.md) | `@on.*` — lifecycle callbacks |
| [Random](utilities/random.md) | `@random` — random string generation |
| [Required](utilities/required.md) | `@required` — dependency validation |
| [Screen](utilities/screen.md) | `@screen.*` — terminal dimensions |
| [Sed](utilities/sed.md) | `@sed` — cross-platform sed wrapper |
| [Strings](utilities/str.md) | `@str.*` — string manipulation |
| [Style](utilities/style.md) | `@style`, `@style.*` — colors and ANSI formatting |
| [Sudo](utilities/sudo.md) | `@sudo` — conditional sudo execution |
| [Throw / Errors](utilities/throw.md) | `@throw`, `@throw.*` — error throwing |
| [Temporary Files](utilities/mktemp.md) | `@mktemp` — safe temp files |
| [User Interaction](utilities/user.md) | `@user.*` — input, confirmation, choice, pause |
| [Validation](utilities/validation.md) | `@isBoolean`, `@isNumber`, `@isRoot`, `@rootValidate` |
| [Wait](utilities/wait.md) | `@wait.*` — polling and waiting |

## Actions

| Reference | Description |
|---|---|
| [Public Actions](actions.md) | `help` and user-facing actions |
| [Framework Actions](actions.md#framework-actions) | `_run-tests`, `_bashx`, `_install-as-command` |

## Testing

| Reference | Description |
|---|---|
| [Assertion Framework](testing.md) | `@@assert.*` — writing and running tests |
