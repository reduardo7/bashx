xbash | Extended Bash Framework
===============================

# Description

Simple bash extension. Bash Framework. Helps to bash programming. Add common functions to help the developer.

## Why use it?

1. Very easy to implement.
2. No additionals components required.
3. No need to learn a new language.
4. No need to learn a new syntax.
5. Common functions and tools.

# Constants

## Configuration

### APP_TITLE

APP title.

Default: *"XBash"*

### APP_VERSION

APP Version.

Default: *"1.0"*

### COLOR_DEFAULT


Default APP color. See "ecolor" for more information.

Default: *"cyan"*
    
### ECHO_CHAR

Start character for formated print screen (see "e" function).

Default: *"#"*

### APP_REQUEIREMENTS

Application requeirements.
To extend requeirements, use:

    APP_REQUEIREMENTS="${APP_REQUEIREMENTS} other app command extra foo"

Default: *"echo printf sed grep tput read date dirname readlink basename tar"*

## Constants

### DEV_NULL

Null path.
Value: *"/dev/null"*
    
### TRUE

Boolean true.
Value: *1*
    
### FALSE

Boolean false.
Value: *0*

# Functions & Methods

## UTILS

### is_root

### check_error

### is_empty

### is_number

### function_exists

### xdie

## STRING

### str_escape

### str_repeat

### str_replace

### trim

### ltrim

### rtrim

### str_len

### sub_str

### str_pos

### in_str

## UI

### screen_width

### ecolor

### e

### eb

### pause

### exit_error

### timeout

### print_line

### cmd_log


### print_app_info

## DATE / TIME

### now_time

### now_date

### now_date_time

## TAR

### tar_compress

### tar_extract

## FILE / PATH

### file_exists

### current_directory

### script_file_name

### script_full_path

### path_exists

### file_contains

## EXEC

### check_requirements

### __usage

### help

### run
