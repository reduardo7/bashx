# Actions

Actions are functions named `@Actions.<name>` and invoked from the CLI as `./my-app <name>`. Actions whose names start with `_` are hidden from `help` (visible with `help -a`).


---

**Contents:**

- [`Public Actions`](#public-actions)
  - [`help`](#help)
- [`Framework Actions`](#framework-actions)
  - [`_run-tests`](#_run-tests)
  - [`_run-tests-docker`](#_run-tests-docker)
  - [`_run-tests-all`](#_run-tests-all)
  - [`_dev-doc`](#_dev-doc)
  - [`_install-as-command`](#_install-as-command)
  - [`_bashx`](#_bashx)
- [`Writing Custom Actions`](#writing-custom-actions)
- [`[--dry-run] <environment>`](#dry-run-environment)
- [`Deploy the application.`](#deploy-the-application)
- [`Options:`](#options)
- [`--dry-run: Simulate without applying changes.`](#dry-run-simulate-without-applying-changes)
  - [`Lifecycle Events`](#lifecycle-events)

---


## Public Actions

### `help`

**File:** `src/actions/help.xsh`

```
./my-app help [-a]
```

Print usage for the script and all available actions.

| Option        | Description                                |
| ------------- | ------------------------------------------ |
| `-a`, `--all` | Include hidden actions (prefixed with `_`) |

```bash
./bashx help
./bashx help -a
```

---

## Framework Actions

These actions are prefixed with `_` and are hidden from the default help output.

### `_run-tests`

**File:** `src/actions/_run-tests.xsh`

```
./bashx _run-tests <name?>*
```

Run the test suite. Pass one or more test names (filenames without `.xsh`) to run a subset.

```bash
# Run all tests
./bashx _run-tests

# Run specific tests
./bashx _run-tests args str.trim

# Run a single test
./bashx _run-tests array
```

---

### `_run-tests-docker`

**File:** `src/actions/_run-tests-docker.xsh`

```
./bashx _run-tests-docker <image?>*
```

Run the test suite inside Docker containers. Defaults to `ubuntu` and `debian:8` (matching CI).

```bash
./bashx _run-tests-docker
./bashx _run-tests-docker ubuntu:22.04
./bashx _run-tests-docker ubuntu debian:bullseye alpine
```

---

### `_run-tests-all`

**File:** `src/actions/_run-tests-all.xsh`

Run Docker tests followed by local tests in a single command.

```bash
./bashx _run-tests-all
```

---

### `_dev-doc`

**File:** `src/actions/_dev-doc.xsh`

Print development documentation for all utilities (piped through `less`).

```bash
./bashx _dev-doc
```

---

### `_install-as-command`

**File:** `src/actions/_install-as-command.xsh`

```
./my-app _install-as-command [-f] <action>
```

Install or uninstall shell auto-completion for the script.

| Param    | Value       | Description                                          |
| -------- | ----------- | ---------------------------------------------------- |
| `action` | `install`   | Add completion to `~/.bashrc`, `~/.zshrc`, `~/.shrc` |
| `action` | `uninstall` | Remove completion                                    |

| Option          | Description               |
| --------------- | ------------------------- |
| `-f`, `--force` | Skip confirmation prompts |

```bash
./my-app _install-as-command install
./my-app _install-as-command -f install
./my-app _install-as-command uninstall
```

---

### `_bashx`

**File:** `src/actions/_bashx.xsh`

```
./bashx _bashx <task> <action> <value1?> <value2?> <value3?>
```

BashX framework scaffolding utility.

#### Initialize a new project

```bash
./bashx _bashx init project v3.2.0 my-app
./bashx _bashx init project v3.2.0 ~/projects/my-script.sh "My App Title"
```

#### Create a configuration file

```bash
./bashx _bashx init config
```

#### Add an action

```bash
./bashx _bashx action add deploy
# Creates src/actions/deploy.xsh (or my-app.src/actions/deploy.xsh)
```

#### Remove an action

```bash
./bashx _bashx action remove deploy
```

#### Add a utility

```bash
./bashx _bashx util add db.connect
# Creates src/utils/db/connect.xsh
```

#### Add a test

```bash
./bashx _bashx test add db.connect
# Creates src/tests/db.connect.xsh
```

#### Add an event

```bash
./bashx _bashx event add ready
./bashx _bashx event add start
./bashx _bashx event add error
./bashx _bashx event add finish
./bashx _bashx event add invalid-action
```

#### Add a resource

```bash
./bashx _bashx resource add ./templates/config.tpl
```

---

## Writing Custom Actions

Define a function `@Actions.<name>` in your script or in `src/actions/<name>.xsh`:

```bash
## [--dry-run] <environment>
## Deploy the application.
## Options:
##   --dry-run: Simulate without applying changes.
@Actions.deploy() {
  eval "$(@args 'dry_run:--dry-run')"

  local env="${BX_SCRIPT_ARGS[1]:-production}"

  ${args_dry_run} && @log "DRY RUN mode"
  @log "Deploying to: ${env}"

  @required git docker

  # ...
}
```

The first `##` line is the usage signature shown in `help`. Subsequent `##` lines are the description.

### Lifecycle Events

Place `.xsh` files in your `events/` directory to hook into the app lifecycle:

| File                 | Fired when                      |
| -------------------- | ------------------------------- |
| `ready.xsh`          | Before action dispatch          |
| `start.xsh`          | Action dispatch begins          |
| `error.xsh`          | Script exits with non-zero code |
| `finish.xsh`         | Script exits (any code)         |
| `invalid-action.xsh` | Unknown action is invoked       |
