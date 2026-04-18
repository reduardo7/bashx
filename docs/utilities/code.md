# Code — `@code.*`

Script processing and variable name utilities.

---

## `@code.variableClean`

**File:** `src/utils/code/variableClean.xsh`

```
@code.variableClean text...
```

Replace all characters that are invalid in a Bash variable name with `_`.

```bash
clean="$(@code.variableClean "my-var name")"
# clean = "my_var_name"

clean="$(@code.variableClean "foo.bar.baz")"
# clean = "foo_bar_baz"

# Dynamic variable names
key="user.first-name"
varname="$(@code.variableClean "prop_${key}")"
# varname = "prop_user_first_name"
declare "${varname}=Eduardo"
```

---

## `@code.scriptMinify`

**File:** `src/utils/code/scriptMinify.xsh`

Minify a Bash script by stripping comments and compressing whitespace. Used internally when generating bootstrap loaders for new projects.

```bash
# Minify a script and write to stdout
@code.scriptMinify < my-script.sh

# Embed a minified version of a library
minified="$(@code.scriptMinify < lib/utils.sh)"
```
