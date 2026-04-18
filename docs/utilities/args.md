# Argument Parsing — `@args`

**File:** `src/utils/args.xsh`

Parse CLI flags and options within an action function.

---

## `@args`

```
eval "$(@args <options>*)"
```

Generates and evaluates shell code that parses `$@` into named local variables. Each option spec has the format `VARIABLE:KEY[:INPUT]`.

| Field | Description |
|---|---|
| `VARIABLE` | Local variable name (prefixed with `args_`). |
| `KEY` | Flag(s) starting with `-`. Use `\|` to allow aliases (e.g. `-v\|--verbose`). |
| `INPUT` | Boolean. `true` = the flag accepts a value. Default: `false` (flag only). |

### Variables

| Variable | Type | Default | Description |
|---|---|---|---|
| `BASHX_args_fail_on_unexpected` | Boolean | `true` | Exit with error on unknown flags |

### Boolean flag

```bash
@Actions.build() {
  eval "$(@args 'verbose:-v|--verbose')"
  # $args_verbose is "true" if -v or --verbose was passed, "false" otherwise

  if ${args_verbose}; then
    @log "Verbose mode enabled"
  fi
}
```

### Flag with value

```bash
@Actions.deploy() {
  eval "$(@args 'env:-e|--env:true' 'tag:-t|--tag:true')"
  # $args_env and $args_tag are arrays of supplied values

  local environment="${args_env[0]:-production}"
  local version="${args_tag[0]:-latest}"

  @log "Deploying ${version} to ${environment}"
}
# Usage: ./my-app deploy -e staging -t v1.2.3
```

### Combined flags

```bash
@Actions.publish() {
  eval "$(@args 'dry_run:-n|--dry-run' 'force:-f|--force' 'path:-p|--path:true')"

  ${args_dry_run} && @log "Dry run mode"
  ${args_force}   && @log "Force mode"

  local target="${args_path[0]}"
  [ -z "${target}" ] && @app.error "Path is required (-p)"

  @log "Publishing to: ${target}"
}
```

### Allow unknown flags

```bash
BASHX_args_fail_on_unexpected=false
eval "$(@args 'verbose:-v')"
```

> **Note:** Using `set -x` with `@args` produces verbose trace output — this is expected and documented in the source.
