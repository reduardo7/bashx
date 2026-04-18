# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

BashX is a Bash framework for writing scripts: a convention-based loader turns `.xsh` files into `@`-prefixed functions, plus an auto-generated help/CLI dispatcher. There is no compile step — everything is sourced at runtime.

## Commands

All commands are run through the `./bashx` entrypoint at the repo root.

- `./bashx` — run default action (`help`)
- `./bashx help` / `./bashx help -a` — list public / all actions
- `./bashx _run-tests` — run all assertion tests under `src/tests/`
- `./bashx _run-tests <name>...` — run specific tests (filename without `.xsh`), e.g. `./bashx _run-tests args str.trim`
- `./bashx _run-tests-docker [image...]` — run tests in Docker; defaults to `ubuntu debian:8` (matches CI in `.github/workflows/test-scripts.yml`)
- `./bashx _run-tests-all` — Docker + local tests
- `./bashx _dev-doc` — print development documentation
- `./bashx _bashx` — list framework utilities; use subcommands (e.g. `_bashx init project <version> <path>`) to scaffold projects, add actions/utils/tests/events/resources

Tests are plain `.xsh` files calling `@@assert.*` helpers (see `src/utils/asserts/load.xsh`). To author a test: drop a file into `src/tests/`, use `@@assert.exec "<fn>" <expected-bool-or-exit-code> '<args>'` for function-level assertions, or other `@@assert.*` helpers directly. Exit 0 = pass.

## Architecture

### Entrypoint flow

1. `bashx` (root script) exports `BASHX_VERSION` and sources `src/init.sh` via the bootstrap inline block. Downstream user scripts use the same block (copied verbatim, only `BASHX_VERSION` changes) — see `README.md` "Manual start".
2. `src/init.sh` resolves symlinks, forces a `bash` interpreter, then loads `config.init.src` → `constants.src` → `config.src` → `${BASHX_APP_CONFIG_FILE}` (defaults to `<script>/.env`).
3. `@function.load` (from `src/utils/function/load.xsh`) walks `src/utils/` and `src/actions/` recursively, creating stub functions that lazy-source the matching `.xsh` file on first call. Custom `BASHX_UTILS_PATH` / `BASHX_ACTIONS_PATH` are loaded after, so user scripts can override framework utilities.
4. User code defines `@Actions.<name>() { ... }` functions, then calls `@app.run` at EOF. `@app.run` (`src/utils/app/run.xsh`) reads `BX_SCRIPT_ARGS[0]` as the action, fires lifecycle events, and dispatches.

### Naming → file mapping

The convention is strict and load-bearing; don't invent new prefixes.

- `src/utils/foo.xsh` → `@foo`
- `src/utils/foo/bar.xsh` → `@foo.bar` (nested dirs become dotted names)
- `src/actions/<name>.xsh` → `@Actions.<name>`, invokable as `./bashx <name>`
- Actions starting with `_` are hidden from `help` (shown with `help -a`) — reserve `_` for framework/dev actions
- Asserts use a double-`@` prefix (`@@assert.*`) and must be loaded explicitly via `@asserts.load` before use (see `_run-tests.xsh`)

### Variable prefixes

- `BX_*` — readonly framework internal constants (`constants.src`) — do not assign
- `BASHX_*` — user-configurable settings (`config.init.src`, `config.src`, or `.env`)
- `args_*` — locals produced by `eval "$(@args ...)"` inside actions

### Documentation-as-code

`help` and `_dev-doc` parse source files for lines starting with `BASHX_DOC_MARK` (default `##`). The first `##` line is the usage signature; subsequent `##` lines are the description. See `src/utils/usage.xsh` for the parser and any existing action/util for the expected comment layout. New `.xsh` files should include this header or they won't appear in `help`.

**Argument format in the signature line:**

- Required positional arg: `<arg-name>`
- Optional positional arg: `<arg-name?>`
- Variadic required: `<arg-name>*`
- Variadic optional: `<arg-name?>*`
- Boolean flag: `[-f]` or `[-f|--flag]` (no angle brackets)
- Flag with argument: `-f <arg-name>` or `-f <arg-name?>`
- Special (stdin, callback, variadic pass-through): `<<`, `@`, `*` — unchanged

Examples: `## <src> <prefix?> <cmd?> <sep?>`, `## [-f] <action>`, `## <command> <interval?> <timeout?>`

This same `<arg>` / `<arg?>` convention applies to inline action signatures defined directly in the entrypoint script using the `# <args> \\n description` comment syntax on `@Actions.*()` function declarations. Example: `@Actions.action2() { # <param1> <param2?> \\n Description`

### Project layout for user scripts

A user script `my-app` expects a sibling `my-app.src/` directory with optional `actions/`, `utils/`, `tests/`, `events/`, `resources/` subdirs. Events under `src/events/` are fired by `@app.run` in this order: `invalid-action` → `ready` → `start` → `error` → `finish` (constant `BX_EVENTS_OPTS`). The in-repo example of this layout is `bashx.src/` (the `bashx` script's own sources).

### Cross-platform guardrails

The framework targets macOS, Linux, and MinGW (see OS detection in `constants.src`). When adding utilities that call `sed`, `readlink`, etc., use the provided wrappers (e.g. `src/utils/sed.xsh` handles the `sed -i` macOS/Linux split) rather than calling the binary directly.

## Conventions for new `.xsh` files

- End every `.xsh` file with the vim modeline already used throughout:
  `# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab`
- Use `@log` / `@log.warn` / `@log.alert` for user-facing output; reserve plain `echo` for function return values (stdout is treated as data).
- Exit / error via `@app.exit` and `@app.error`, not bare `exit`.
- Avoid calling `@`-functions inside `set -x` blocks — the DEBUG trap interacts badly with nested functions (noted in `README.md`).
