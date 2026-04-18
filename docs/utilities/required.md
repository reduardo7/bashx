# Required — `@required`

**File:** `src/utils/required.xsh`

```
@required <cmd>*
```

Verify that one or more commands are available in `$PATH`. Exits with an error message listing any missing commands.

```bash
# Single dependency
@required docker

# Multiple dependencies
@required docker docker-compose

# Full tool set
@required git curl jq npm node

# In an action
@Actions.build() {
  @required make gcc pkg-config
  make all
}
```

If any command is missing, the script exits immediately with output like:

```
Required software not found: docker-compose jq
```
