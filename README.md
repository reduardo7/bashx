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


#### SOURCES_PATH

Sources path.


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


#### RESULT

Result value for some functions.


#### ACTION

Current called action.

# Functions & Methods



## Log


#### console.log

Write to LOG to Console.

##### Params

* `*`: Text to log.

##### Example

```
console.log 'Test message'
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


#### is_root

Check if run as Root User.

##### Return

`$TRUE` if *is* root user, `$FALSE` is *not* root user.

##### Example

```
if is_root ; then
  e "Running as root user"
fi
```


#### root_validator

Check if running as root user, or exit from script.

##### Params

* `*`: (Optional) Message.

##### Example

```
root_validator "You are not root"
```


#### is_empty

Check if input is empty.

##### Params

1. *Required*. Variable to check if emtpy.

##### Return

`$TRUE` if empty, `$FALSE` if not empty.

##### Example

```
local x="$1"
if is_empty "$x" ; then
    error "The first parameter is required"
fi
```


#### check_error

#### is_number

#### function_exists

## STRING

#### str_escape

#### str_repeat

#### str_replace

#### trim

#### ltrim

#### rtrim

#### str_len

#### sub_str

#### str_pos

#### in_str

## UI

#### screen_width

#### style

#### e

#### eb

#### pause

#### exit_error

#### timeout

#### print_line

#### cmd.log


#### print_app_info

## DATE / TIME

#### now_time

#### now_date

#### now_date_time

## TAR

#### tar_compress

#### tar_extract

## FILE / PATH

#### file_exists

#### script_file_name

#### script_full_path

#### path_exists

#### file_contains

## EXEC

#### check_requirements

#### usage

#### help

#### run
