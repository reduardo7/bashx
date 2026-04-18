# Strings — `@str.*`

String manipulation utilities.

---

## `@str.trim`

**File:** `src/utils/str/trim.xsh`

```
@str.trim text [to_remove]
```

Remove leading and trailing characters from a string.

| Param | Type | Default | Description |
|---|---|---|---|
| `text` | String | — | Input string |
| `to_remove` | String | `" "` | Character(s) to strip |

```bash
result="$(@str.trim "  hello world  ")"
# result = "hello world"

result="$(@str.trim "###title###" "#")"
# result = "title"
```

---

## `@str.ltrim`

**File:** `src/utils/str/ltrim.xsh`

```
@str.ltrim text [to_remove]
```

Remove leading characters only.

```bash
result="$(@str.ltrim "  hello" " ")"
# result = "hello"
```

---

## `@str.rtrim`

**File:** `src/utils/str/rtrim.xsh`

```
@str.rtrim text [to_remove]
```

Remove trailing characters only.

```bash
result="$(@str.rtrim "hello  " " ")"
# result = "hello"
```

---

## `@str.len`

**File:** `src/utils/str/len.xsh`

```
@str.len text...
```

Return the character length of a string, ignoring ANSI color codes.

```bash
len="$(@str.len "hello")"
# len = 5

colored="$(@style color:red)hello$(@style)"
len="$(@str.len "${colored}")"
# len = 5  (color codes excluded)
```

---

## `@str.sub`

**File:** `src/utils/str/sub.xsh`

```
@str.sub src limit [offset]
```

Extract a substring.

| Param | Type | Default | Description |
|---|---|---|---|
| `src` | String | — | Input string |
| `limit` | Integer | — | Number of characters |
| `offset` | Integer | `0` | Start position |

```bash
result="$(@str.sub "hello world" 5)"
# result = "hello"

result="$(@str.sub "hello world" 5 6)"
# result = "world"
```

---

## `@str.replace`

**File:** `src/utils/str/replace.xsh`

```
@str.replace src search replace [ignore_case]
```

Replace a pattern (regex) in a string using Perl.

| Param | Type | Default | Description |
|---|---|---|---|
| `src` | String | — | Input string |
| `search` | String | — | Regex pattern to find |
| `replace` | String | — | Replacement string |
| `ignore_case` | Boolean | `true` | Case-insensitive match |

```bash
result="$(@str.replace "Hello World" "world" "Bash")"
# result = "Hello Bash"  (case-insensitive by default)

result="$(@str.replace "foo123bar" "[0-9]+" "NUM")"
# result = "fooNUMbar"

result="$(@str.replace "Hello" "hello" "Hi" false)"
# result = "Hello"  (no match, case-sensitive)
```

---

## `@str.toLower`

**File:** `src/utils/str/toLower.xsh`

```
@str.toLower text...
```

Convert string to lowercase.

```bash
result="$(@str.toLower "Hello World")"
# result = "hello world"
```

---

## `@str.toUpper`

**File:** `src/utils/str/toUpper.xsh`

```
@str.toUpper text...
```

Convert string to uppercase.

```bash
result="$(@str.toUpper "hello world")"
# result = "HELLO WORLD"
```

---

## `@str.repeat`

**File:** `src/utils/str/repeat.xsh`

```
@str.repeat count str
```

Repeat a string `count` times.

| Param | Type | Description |
|---|---|---|
| `count` | Integer | Number of repetitions |
| `str` | String | String to repeat |

```bash
result="$(@str.repeat 5 "-")"
# result = "-----"

result="$(@str.repeat 3 "ab")"
# result = "ababab"
```

---

## `@str.in`

**File:** `src/utils/str/in.xsh`

```
@str.in src search [case_sensitive]
```

Check whether a string contains a substring.

| Param | Type | Default | Description |
|---|---|---|---|
| `src` | String | — | String to search in |
| `search` | String | — | Substring to find |
| `case_sensitive` | Boolean | `true` | Case-sensitive search |

**Returns:** `0` if found, `1` if not.

```bash
if @str.in "hello world" "world"; then
  @log "Contains 'world'"
fi

if @str.in "Hello World" "hello" false; then
  @log "Case-insensitive match"
fi
```

---

## `@str.pos`

**File:** `src/utils/str/pos.xsh`

```
@str.pos src search [case_sensitive]
```

Return the zero-based position of a substring, or print nothing if not found.

**Returns:** `0` if found, `1` if not.

```bash
pos="$(@str.pos "hello world" "world")"
# pos = 6

if @str.pos "hello" "xyz" > /dev/null; then
  @log "Found"
else
  @log "Not found"
fi
```

---

## `@str.escape`

**File:** `src/utils/str/escape.xsh`

```
@str.escape text...
```

Escape a string for safe use as a Bash argument (`printf '%q'`).

```bash
user_input="hello 'world' & more"
safe="$(@str.escape "${user_input}")"
eval "echo ${safe}"
```
