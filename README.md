BashX | Extended Bash Framework
===============================

# Description

Simple bash extension. Bash Framework. Helps to bash programming. Add common functions to help the developer.

Compatible with Android Bash!

## Why use it?

1. Very easy to implement.
2. No additionals components required.
3. No need to learn a new language.
4. No need to learn a new syntax.
5. Common functions and tools.



# Constants

## OS Check

### OS_IS_LINUX

Value: `true` if current OS is Linux.

### OS_IS_MAC

Value: `true` if current OS is MAC.

### OS_IS_MINGW

Value: `true` if current OS is MINGW (Windows).

## Configuration


#### APP_TITLE

APP title.

Default: `"BashX"`


#### APP_VERSION

APP Version.

Default: `"1.0"`


#### COLOR_DEFAULT

Default APP color. See `style` for more information.

Default: `"cyan"`


#### ECHO_CHAR

Start character for formated print screen (see "e" function).

Default: `"#"`


#### APP_REQUEIREMENTS

Application requeirements.
To extend requeirements, use:

    APP_REQUEIREMENTS="${APP_REQUEIREMENTS} other app command extra foo"

Default: `"echo printf sed grep tput read date dirname readlink basename tar"`


#### DEFAULT_ACTION

Default action to call
Action to use if script called without arguments.

Default: `"usage"`


#### LOG_FILE

Log file (& path).

Default: `"$0.log"`


#### CONFIG_FILE

Config file.


#### RESOURCES_PATH

Resources path.


#### TRUE

Boolean true.
Value: `1`


#### FALSE

Boolean false.
Value: `0`


#### BASE_SOURCE

Base script source.


#### BASE_DIR

Base script directory.


#### KEY_ESC

Key: ESC
Char: `"$'\e'"`



# Global Common Variables


#### ACTION

Current called action.

# Functions & Methods



## Log


#### @console-log

Write to LOG to Console.

##### Params

* `*`: Text to log.

##### Example

```
@console-log 'Test message'
# Print the log text
```


#### write.log

Write to LOG to File.

##### Params

* `*`: Text to log.

##### See

`LOG_FILE` constant.

##### Example

```
write.log 'Test message'
cat "$LOG_FILE"
# Print the log file
```


## UTILS


#### @is-root

Check if run as Root User.

##### Return

`0` if *is* root user, `1` is *not* root user.

##### Example

```
if @is-root ; then
  e "Running as root user"
fi
```


#### @root-validator

Check if running as root user, or exit from script.

##### Params

* `*`: (Optional) Message.

##### Example

```
@root-validator "You are not root"
```


#### @is-empty

Check if input is empty.

##### Params

1. *Required*. Variable to check if emtpy.

##### Return

`0` if empty, `1` if not empty.

##### Example

```
local x="$1"
if @is-empty "$x" ; then
    error "The first parameter is required"
fi
```

## Testing

### Assert Functions

#### @@assertFail

Fails when it is called.

##### Params

**message** *{String}* Description about fail.

#### @@assertTrue

Fails when the parameter is not `true`.

##### Params

**var** Parameter to test.

#### @@assertFalse

Fails when the parameter is not `false`.

##### Params

**var** Parameter to test.

#### @@assertEmpty

Fails when the parameter is not *empty*.

##### Params

**var** *{String}* Parameter to test.

#### @@assertNotEmpty

Fails when the parameter is *empty*.

##### Params

**var** *{String}* Parameter to test.

#### @@assertNumber

Fails when the parameter is not a *number*.

##### Params

**var** Parameter to test.

#### @@assertErrorCode

Fails when the parameter is not a *number* or is an invalid *error code* (`code == 0` or `code > 255`).

##### Params

**code** Error code to test.

### @@assertNotErrorCode

Fails when the parameter is not a *number* or is a valid *error code* (`code == 0`).

##### Params

**code** Error code to test.

### @@assertEqual

Fails when the parameter *a* is not equal to parameter *b*.

##### Params

**str_a** *{String}* Parameter to test *a*.
**str_b** *{String}* Parameter to test *b*.

#### @@assertNotEqual

Fails when the parameter *a* is equal to parameter *b*.

##### Params

**str_a** *{String}* Parameter to test *a*.
**str_b** *{String}* Parameter to test *b*.

#### @@assertContains

Fails when the parameter *base* contains parameter *search*.

##### Params

**str_base** *{String}* String where to search.
**str_search** *{String}* Strint to search.

#### @@assertNotContains

Fails when the parameter *base* not contains parameter *search*.

##### Params

**str_base** *{String}* String where to search.
**str_search** *{String}* Strint to search.

#### @@assertStartWith

Fails when the parameter *base* starts with parameter *search*.

##### Params

**str_base** *{String}* String where to search.
**str_search** *{String}* Strint to search.

#### @@assertEndWith

Fails when the parameter *base* ends with parameter *search*.

##### Params

**str_base** *{String}* String where to search.
**str_search** *{String}* Strint to search.

#### @@assertStdOut

Fails when the command to execute does not have *std out*.

##### Params

**cmd** *{String}* Command to execute.

#### @@assertNoStdOut

Fails when the command to execute has *std out*.

##### Params

**cmd** *{String}* Command to execute.

#### @@assertErrOut

Fails when the command to execute does not have *err out*.

##### Params

**cmd** *{String}* Command to execute.

#### @@assertNoErrOut

Fails when the command to execute has *err out*.

##### Params

**cmd** *{String}* Command to execute.

#### @@assertNoOut

Fails when command to execute does not have *std out* or *err out*.

##### Params

**cmd** *{String}* Command to execute.

#### @@assertExec

Fails when the command to execute does not have the expected exit.

##### Params

**fn_name** *{String}* Function name (only it).
**expected_exit** *{Boolean|Integer}* Expected execution result. `true` for *exit code = 0*; `false` for *exit code != 0*; *number* for expected *exit code*.
**params** *{String}* *(Optional)* Parameter/s to use with the specified *function*. Examples: `true`, `"option a" "foo" false`, `123 ""`.

#### @@assertRegExp

Fails when the parameter to test no pass the *RegExp*.

##### Params

**reg_exp** *{String}* Test RegExp.
**str** *{String}* String to test.

### How run Core tests

1. Delete downloaded `src/bashx`: `$ rm -r src/bashx`
2. Create sym-link: `cd src && ln -s .. bashx && cd ..`
3. Run tests: `./app run-tests`

# Optimizations

See: http://tldp.org/LDP/abs/html/optimizations.html
