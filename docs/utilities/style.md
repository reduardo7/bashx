# Style / Colors — `@style`, `@style.*`

ANSI terminal styling utilities.

Set `BASHX_COLORS_DISABLED=1` to disable all color output globally.


---

**Contents:**

- [`@style`](#style)
  - [`Colors`](#colors)
  - [`Background colors`](#background-colors)
  - [`Text styles`](#text-styles)
  - [`Combining styles`](#combining-styles)
  - [`Supported color names`](#supported-color-names)
  - [`Reset`](#reset)
- [`@style.clean`](#styleclean)

---


## `@style`

**File:** `src/utils/style.xsh`

```
@style <options?>*
```

Output ANSI escape codes for colors and formatting. Call without arguments (or with `reset`/`default`) to restore defaults.

### Colors

```bash
@log "$(@style color:red)Error!$(@style)"
@log "$(@style color:green)Success$(@style)"
@log "$(@style color:blue)Info$(@style)"
@log "$(@style color:yellow)Warning$(@style)"

# 256-color support
@log "$(@style color:202)Orange text$(@style)"
```

### Background colors

```bash
@log "$(@style background:blue)Blue background$(@style)"
@log "$(@style bg:red)Red background$(@style)"
```

### Text styles

```bash
@log "$(@style bold)Bold text$(@style)"
@log "$(@style underline)Underlined$(@style)"
@log "$(@style dim)Dimmed$(@style)"
@log "$(@style blink)Blinking$(@style)"
@log "$(@style reverse)Reversed$(@style)"
```

### Combining styles

```bash
@log "$(@style bold color:red)Bold red error$(@style)"
@log "$(@style underline color:cyan)Underlined cyan$(@style)"
@log "$(@style bg:yellow color:black)Black on yellow$(@style)"
```

### Supported color names

`black`, `blue`, `cyan`, `gray`, `green`, `magenta`, `red`, `yellow`, `white`, or any 256-color number `0`–`255`.

### Reset

```bash
@style        # Reset all styles
@style reset  # Same as above
@style default
```

---

## `@style.clean`

**File:** `src/utils/style/clean.xsh`

```
@style.clean <text>*
```

Strip all ANSI escape codes from a string. Useful when you need the plain-text length or want to write to a log file.

```bash
colored="$(@style color:red)Error$(@style): something failed"
plain="$(@style.clean "${colored}")"
# plain = "Error: something failed"

# @str.len already uses @style.clean internally
len="$(@str.len "${colored}")"
# len = 23 (not counting escape bytes)
```
