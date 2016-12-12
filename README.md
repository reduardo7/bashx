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


#### DEV_NULL

Null path.
Value: `"/dev/null"`


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
