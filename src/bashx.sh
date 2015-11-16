#!/bin/bash

## BashX
##
## Extended Bash Framework.
##
## URL: https://github.com/reduardo7/bashx
##
## Author: Eduardo Cuomo | eduardo.cuomo.ar@gmail.com | reduardo7@gmail.com

# #############################################################################

# Init.
# Add the following lines at beginning of your file script:
#   #!/bin/bash
#   . "$(dirname "$0")/src/bashx.sh"

# #############################################################################

# Test and force run with "bash" interpreter.
if [ -z "$BASH" ]; then
    bash "$0" "$@"
    exit $?
fi

# Go to script path (working directory)
cd "$(dirname "$0")"

# #############################################################################

### CONFIG
# Update with your configuration or use the "config.ini" file.

    # APP Title.
    export APP_TITLE="BashX"

    # APP Version.
    export APP_VERSION="1.0"

    # Default APP color. See "style" for more information.
    #COLOR_DEFAULT="system" # Default system color
    export COLOR_DEFAULT="cyan"

    # Start character for formated print screen (see "e" function).
    export ECHO_CHAR="#"

    # Application requeirements.
    # To extend requeirements, use:
    #   export APP_REQUEIREMENTS="${APP_REQUEIREMENTS} other app command extra foo"
    export APP_REQUEIREMENTS="printf sed grep read date dirname readlink basename let"

    # Default action to call
    # Action to use if script called without arguments.
    export DEFAULT_ACTION="usage"

    # BashX SRC path.
    export SRC_PATH="src"

    # BashX Version.
    export BASHX_VERSION="1.7.6"

    # Log file (& path).
    export LOG_FILE="$0.log"

    # Config file.
    export CONFIG_FILE="$CONFIG_FILE"

    # Actions directory name
    export ACTIONS_DIR="actions"

    # Actions path
    export ACTIONS_PATH="./${SRC_PATH}/${ACTIONS_DIR}"

    # Sources directory name
    export SOURCES_DIR="sources"

    # Sources path
    export SOURCES_PATH="./${SRC_PATH}/${SOURCES_DIR}"

### CONSTANTS

    # BashX Current source.
    BASHX_CURRENT_SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$BASHX_CURRENT_SOURCE" ]; do # resolve $BASHX_CURRENT_SOURCE until the file is no longer a symlink
        BASHX_CURRENT_DIR="$(cd -P `dirname "$BASHX_CURRENT_SOURCE"` && pwd)"
        BASHX_CURRENT_SOURCE=`readlink "$BASHX_CURRENT_SOURCE"`
        [[ $BASHX_CURRENT_SOURCE != /* ]] && BASHX_CURRENT_SOURCE="$BASHX_CURRENT_DIR/$BASHX_CURRENT_SOURCE" # if $BASHX_CURRENT_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    [ -z "$BASHX_CURRENT_DIR"] && BASHX_CURRENT_DIR="$(cd -P `dirname "$BASHX_CURRENT_SOURCE"` && pwd)"
    export BASHX_CURRENT_SOURCE="$BASHX_CURRENT_SOURCE"
    readonly BASHX_CURRENT_SOURCE="$BASHX_CURRENT_SOURCE"

    # BashX Current path
    export BASHX_CURRENT_DIR="$BASHX_CURRENT_DIR"
    readonly BASHX_CURRENT_DIR="$BASHX_CURRENT_DIR"

    # Current source.
    CURRENT_SOURCE="$0"
    while [ -h "$CURRENT_SOURCE" ]; do # resolve $CURRENT_SOURCE until the file is no longer a symlink
        CURRENT_DIR="$(cd -P `dirname "$CURRENT_SOURCE"` && pwd)"
        CURRENT_SOURCE=`readlink "$CURRENT_SOURCE"`
        [[ $CURRENT_SOURCE != /* ]] && CURRENT_SOURCE="$CURRENT_DIR/$CURRENT_SOURCE" # if $CURRENT_SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    [ -z "$CURRENT_DIR" ] && CURRENT_DIR="$(cd -P `dirname "$CURRENT_SOURCE"` && pwd)"
    export CURRENT_SOURCE="$CURRENT_SOURCE"
    readonly CURRENT_SOURCE="$CURRENT_SOURCE"

    # Current path
    export CURRENT_DIR="$(cd -P `dirname "$CURRENT_DIR"` && pwd)"
    readonly CURRENT_DIR="$CURRENT_DIR"

    # Null path.
    export DEV_NULL="/dev/null"
    readonly DEV_NULL="$DEV_NULL"

    # Boolean true.
    export TRUE=0
    readonly TRUE="$TRUE"

    # Boolean false.
    export FALSE=1
    readonly FALSE="$FALSE"

    # Key: ESC
    # \e | \033 | \x1B
    export KEY_ESC=$'\e'
    readonly KEY_ESC="$KEY_ESC"

### Load files

    # Config
    if [ -z "${CONFIG_FILE}" ]; then
        # Default file
        export CONFIG_FILE="${SRC_PATH}/config.ini"
    fi
    # Load config
    if [ -f "${CONFIG_FILE}" ]; then
        . ${CONFIG_FILE}
    fi

### VARS

    # Result value for some functions
    export RESULT=""

    # Called action
    export ACTION=""

### PRIVATE VARS

    # On exit command
    export _ON_EXIT=''

    # TRUE if APP is terminated
    export _APP_EXIT=$FALSE

### DEBUG & LOG

    # Write to LOG to Console
    console_log() {
        printf "LOG> %.23s | %s[%s]: %s\n" `date +%F.%T.%N` ${BASH_SOURCE[1]##*/} ${BASH_LINENO[0]} "${@}"
    }

    # Write to LOG to File
    write_log() {
        console_log "$@" >> "$LOG_FILE"
    }

### UTILS

    # Check if run as Root.
    #
    # Return: $TRUE if is root, $FALSE is not root.
    is_root() {
        # Is ROOT user?
        if [ "`id -u`" -ne 0 ]; then
            # No Root
            return $FALSE
        else
            # Root
            return $TRUE
        fi
    }

    # Check if running as ROOT, or exit from script.
    #
    # *: (Optional) Message.
    root_validator() {
        if ! is_root ; then
            if [ $# -eq 0 ] ; then
                local m="This script must be run as root!"
            else
                local m="$@"
            fi
            e "$m"
            e
            end 1
        fi
    }

    # Check if is empty.
    #
    # 1: {*} Variable to check if emtpy.
    # Return: $TRUE if empty, $FALSE if not empty.
    is_empty() {
        if [ -z "$1" ]; then
            # Empty
            return $TRUE
        else
            # Not empty
            return $FALSE
        fi
    }

    # Check if is a number.
    #
    # 1: {*} Variable to check if is a number.
    # Return: $TRUE if variable is a number, $FALSE if variable is not a number.
    is_number() {
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            return $TRUE
        else
            return $FALSE
        fi
    }

    # Check if function exists.
    #
    # 1: {String} Function name.
    # Return: $TRUE if function exists, $FALSE if file not exists.
    function_exists() {
        declare -f "$1" > /dev/null
        if [ $? -eq 0 ]; then
            return $TRUE
        else
            return $FALSE
        fi
    }

### STRING

    # Escape string for Bash.
    #
    # *: {String} String to escape for Bash.
    # Out: {String} Escaped string.
    str_escape() {
        if ! is_empty "$@" ; then
            printf '%q' "$@"
        fi
    }

    # Repeat string.
    #
    # 1: {Integer} Number of repetitions.
    # 2: {String} String to repeat.
    # Out: {String} Repeated string.
    str_repeat() {
        let fillsize=$1
        local fill=$2
        while [ ${fillsize} -gt 1 ] ; do
            fill="${fill}$2"
            let fillsize=${fillsize}-1
        done
        echo $fill
    }

    # Replace string.
    #
    # 1: {String} String where replace.
    # 2: {String} Search string (REG EXP).
    # 3: {String} Replace.
    # 4: {Boolean} (Default: 1) 1 to ignore case.
    # Out: {String} Result string.
    str_replace() {
        local options="g"
        if [ $# -lt 4 ] || [ "$4" -ne $TRUE ]; then
            options="${options}i"
        fi
        echo "$1" | sed "s/$2/$3/$options"
    }

    # Explode string into $RESULT as Array.
    #
    # 1: {String} Separator.
    # 2: {String} String to explode.
    # Result in $RESULT.
    # Return: Array length.
    # Use:
    #    str_explode ";" "bla@some.com bbb;john@home.com jjj"
    #    for i in ${RESULT[@]} ; do
    #        echo $i
    #    done
    str_explode() {
        local i="$IFS"
        IFS="$1"
        RESULT=( `echo "$2"` )
        IFS="$i"
        return ${#RESULT[@]}
    }

    # String to lower case.
    #
    # *: {String} String to convert.
    # Out: {String} Result string.
    str_to_lower() {
        echo "$@" | tr '[A-Z]' '[a-z]'
    }

    # String to lower case.
    #
    # *: {String} String to convert.
    # Out: {String} Result string.
    str_to_upper() {
        echo "$@" | tr '[a-z]' '[A-Z]'
    }

    # Trim text.
    #
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    trim() {
        local chr=" "
        if [ $# -gt 1 ]; then
            local chr="$2"
        fi
        echo "$1" | sed "s/^${chr}//g" | sed "s/${chr}$//g"
    }

    # Left trim text.
    #
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    ltrim() {
        local chr=" "
        if [ $# -gt 1 ]; then
            chr="$2"
        fi
        echo "$1" | sed "s/^${chr}//g"
    }

    # Right trim text.
    #
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    rtrim() {
        local chr=" "
        if [ $# -gt 1 ]; then
            chr="$2"
        fi
        echo "$1" | sed "s/${chr}$//g"
    }

    # String length.
    #
    # 1: {String} Text.
    # Out: {Integer} String length.
    # Return: String length.
    str_len() {
        local l=${#1}
        echo $l
        return $l
    }

    # Sub string.
    # 1: {String} String to cut.
    # 2: {Integer} Limit.
    # 3: {Integer} (Optional) Offset.
    # Out: {String} Result string
    sub_str() {
        if [ $# -eq 2 ]; then
            echo ${1:0:$2}
        else
            echo ${1:$3:$2}
        fi
    }

    # String position.
    #
    # 1: {String} String where search.
    # 2: {String} String to search.
    # 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
    # Out: {Integer|NULL} String position or NULL if not found.
    # Return: $TRUE on fonud, $FALSE on not found.
    str_pos() {
        if [ $# -lt 3 ] || [ $3 = $TRUE ]; then
            # Case sensitive
            local p="-bo"
        else
            # Case insensitive
            local p="-boi"
        fi
        local r=`echo "$1" | grep $p "$2" | sed 's/:.*$//'`
        echo $r
        if is_empty "$r" ; then
            # No found
            return $FALSE
        else
            # Found
            return $TRUE
        fi
    }

    # String contains substring?
    #
    # 1: {String} String where search.
    # 2: {String} Substring to search.
    # 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
    # Return: $TRUE if contains substring, $FALSE if not contains substring.
    in_str() {
        if [ $# -lt 3 ]; then
            str_pos "$1" "$2" &> $DEV_NULL
            local r=$?
        else
            str_pos "$1" "$2" "$3" &> $DEV_NULL
            local r=$?
        fi
        return $r
    }

### ERROR

    # Check error.
    #
    # 1: {Integer} Exit code. Example: $?
    # 2: {String} Command to execute on error.
    # Example: check_error $? "error 'Invalid operation'".
    check_error() {
        if is_number "$1"; then
            if [ $1 -gt 0 ]; then
                # Error
                $2
            fi
        fi
    }

    # Check error.
    #
    # 1: {Integer} Exit code. Example: $?
    # 2: {String} Command to execute on error.
    # Example: check_error $? "Invalid operation".
    check_error_end() {
        if is_number "$1"; then
            if [ $1 -gt 0 ]; then
                # Error
                error "$2" $1
            fi
        fi
    }

    # Show error message and exit.
    #
    # 1: {String} Error message.
    # 2: {Integer} (Default: 1) Exit code.
    error() {
        if ! [ -z "$1" ]; then
            alert "Error! $1"
        else
            e
        fi
        if [ $# -gt 1 ]; then
            end $2
        else
            end 1
        fi
    }

### UI

    # Screen width.
    #
    # Out: {Integer} Screen width.
    screen_width() {
        check_requirements tput
        tput cols
    }

    # Change screen print style.
    #
    # 1-*: Style strings.
    #   The style separator can be:
    #       - : (two points)
    #       - = (equal)
    #   Simple:
    #       - bold: Bold text.
    #       - underline: Underline.
    #       - reverse | negative: Invert color.
    #       - hidden | hide: Hide text.
    #       - show | visible: Show hidden text.
    #       - dim: Gray style.
    #       - blink: Flashing text.
    #       - normal: Text without bold format.
    #       - reset: Reset all styles to system default.
    #       - default: Reset all styles to APP style.
    #   Colors: Use "color[:=]*", where "*" can be:
    #       - black
    #       - blue
    #       - blue_light
    #       - cyan
    #       - cyan_light
    #       - gray
    #       - gray_light
    #       - green
    #       - green_light
    #       - magenta | purple
    #       - magenta_light
    #       - red
    #       - red_light
    #       - yellow | coffe
    #       - yellow_light
    #       - white
    #       - default | normal | auto: Default APP color.
    #       - [A Number between 0 and 255]: Print custom color.
    #   Background: Use "background[:=]*" or "bg[:=]*", where "*" can be:
    #       - black
    #       - blue
    #       - blue_light
    #       - cyan
    #       - cyan_light
    #       - gray
    #       - gray_light
    #       - green
    #       - green_light
    #       - magenta | purple
    #       - magenta_light
    #       - red
    #       - red_light
    #       - yellow | coffe
    #       - yellow_light
    #       - white
    #       - system | normal | auto: Default system background color.
    #       - [A Number between 0 and 255]: Print custom color.
    #   Styles: Use as "style[:=]status":
    #       - underline: Underline.
    #           - on | true | 1 | $TRUE: Enable underline.
    #           - off | false | 0 | $FALSE: Disable underline.
    #       - bold: Bold.
    #           - on | true | 1 | $TRUE: Enable bold.
    #           - off | false | 0 | $FALSE: Disable bold.
    #       - dim: Gray style.
    #           - on | true | 1 | $TRUE: Enable dim.
    #           - off | false | 0 | $FALSE: Disable dim.
    #       - blink: Flashing text.
    #           - on | true | 1 | $TRUE: Enable blink.
    #           - off | false | 0 | $FALSE: Disable blink.
    #       - reverse | negative: Invert color.
    #           - on | true | 1 | $TRUE: Enable negative.
    #           - off | false | 0 | $FALSE: Disable negative.
    #       - display: Show or hide text.
    #           - visible | show | true | 1 | $TRUE: Show text.
    #           - hidden | none | hide | false | 0 | $FALSE: Hide text.
    # Out: {String} Style console string.
    # Examples:
    #   e "normal color $(style color:red)text in red $(style color:black background:yellow)black color$(style default) normal color"
    #   style default # Restore default APP colors
    #   style background gray # Set gray color as background color for next output
    #   e "$(style color:red bold underline:on)Title$(style underline:off):$(style normal dim) Description..."
    style() {
        # No parameters
	    local prms="$@"
        if [ $# -eq 0 ]; then
            # Default color
            prms="default"
        fi

        # Styles
        local c=""
        for q in "$prms" ; do
            # Style code
            local y=""
            # To lower
            local p="`str_to_lower "$q"`"
            # Split
            str_explode "[=:]" "$p"
            # Parts
            local s=`trim "${RESULT[0]}"`
            local v=`trim "${RESULT[1]}"`

            # Default
            if [ -z "$v" ] && [ "$p" == "default" ]; then
                # Reset style
                if [ -z "$c" ]; then
                    c="0"
                else
                    c="$c;0"
                fi
                # Default color
                s="color"
                v="${COLOR_DEFAULT}"
            fi

            if [ ! -z "$v" ]; then
                if [ "$s" == "color" ] && ( [ "$v" == "default" ] || [ "$v" == "normal" ] || [ "$v" == "auto" ] ); then
                    if [ -z "${COLOR_DEFAULT}"] || [ "${COLOR_DEFAULT}" == 'default' ] || [ "${COLOR_DEFAULT}" == 'normal' ] || [ "${COLOR_DEFAULT}" == 'auto' ]; then
                        # Invalid default or default not defined
                        y="0"
                        # Invalidate case
                        v=""
                        s=""
                    else
                        # Default color
                        v="${COLOR_DEFAULT}"
                    fi
                fi
                case "$s" in
                    "color")
                        case "$v" in
                            "black")              y="30" ;;
                            "blue")               y="34" ;;
                            "blue_light")         y="94" ;;
                            "cyan")               y="36" ;;
                            "cyan_light")         y="96" ;;
                            "gray")               y="90" ;;
                            "gray_light")         y="37" ;;
                            "green")              y="32" ;;
                            "green_light")        y="92" ;;
                            "magenta" | "purple") y="35" ;;
                            "magenta_light")      y="95" ;;
                            "red")                y="31" ;;
                            "red_light")          y="91" ;;
                            "yellow" | "coffe")   y="33" ;;
                            "yellow_light")       y="93" ;;
                            "white")              y="97" ;;
                            # Color (0 - 255)
                            [0-9])                y="38;5;${v}" ;;
                        esac
                        ;;
                    "background" | "bg")
                        case "$v" in
                            "black")                      y="40" ;;
                            "blue")                       y="44" ;;
                            "blue_light")                 y="104" ;;
                            "cyan")                       y="46" ;;
                            "cyan_light")                 y="106" ;;
                            "gray")                       y="100" ;;
                            "gray_light")                 y="47" ;;
                            "green")                      y="42" ;;
                            "green_light")                y="102" ;;
                            "magenta" | "purple")         y="45" ;;
                            "magenta_light")              y="105" ;;
                            "red")                        y="41" ;;
                            "red_light")                  y="101" ;;
                            "yellow" | "coffe")           y="43" ;;
                            "yellow_light")               y="103" ;;
                            "white")                      y="107" ;;
                            "system" | "normal" | "auto") y="49" ;;
                            # Color (0-255)
                            [0-9])                        y="48;5;${v}" ;;
                        esac
                        ;;
                    "underline")
                        case "$v" in
                            "on" | "true" | "1" | "${TRUE}")    y="4" ;;
                            "off" | "false" | "0" | "${FALSE}") y="24" ;;
                        esac
                        ;;
                    "bold")
                        case "$v" in
                            "on" | "true" | "1" | "${TRUE}")    y="1" ;;
                            "off" | "false" | "0" | "${FALSE}") y="21" ;;
                        esac
                        ;;
                    "dim")
                        # Gray stile
                        case "$v" in
                            "on" | "true" | "1" | "${TRUE}")    y="2" ;;
                            "off" | "false" | "0" | "${FALSE}") y="22" ;;
                        esac
                        ;;
                    "blink")
                        # Flashing text
                        case "$v" in
                            "on" | "true" | "1" | "${TRUE}")    y="5" ;;
                            "off" | "false" | "0" | "${FALSE}") y="25" ;;
                        esac
                        ;;
                    "reverse" | "negative")
                        case "$v" in
                            "on" | "true" | "1" | "${TRUE}")    y="7" ;;
                            "off" | "false" | "0" | "${FALSE}") y="27" ;;
                        esac
                        ;;
                    "display")
                        case "$v" in
                            "visible" | "show" | "true" | "1" | "${TRUE}")           y="28" ;;
                            "hidden" | "none" | "hide" | "false" | "0" | "${FALSE}") y="8" ;;
                        esac
                        ;;
                esac
            else
                case "$p" in
                    "bold")                 y="1" ;;
                    "underline")            y="4" ;;
                    "reverse" | "negative") y="7" ;;
                    "hidden" | "hide")      y="8" ;;
                    "show" | "visible")     y="28" ;;
                    # Gray stile
                    "dim")                  y="2" ;;
                    # Flashing text
                    "blink")                y="5" ;;
                    # No bold
                    "normal")               y="21" ;;
                    # Reset all styles
                    "reset")                y="0" ;;
                esac
            fi
            if [ ! -z "$y" ]; then
                # Append style
                if [ -z "$c" ]; then
                    c="$y"
                else
                    c="$c;$y"
                fi
            fi
        done
        if [ ! -z "${c}" ]; then
            echo -en "\e[${c}m"
        fi
    }

    # Print gradiant line.
    #
    # 1: {Integer} [0-255] From color.
    # 2: {Integer} [0-255] To color.
    # 3: {Char} (Default: #) Character to print.
    # Out: {String} Colorized line.
    print_colorized_line_char() {
        # Char
        if [ $# -gt 2 ]; then
            local c="$3"
        else
            local c="#"
        fi
        # Print
        for i in {${1}..${2}} {${2}..${1}} ; do
            echo -en "`style color:${i}`${c}"
        done
        # Default
        style default
    }

    # Print gradiant line.
    #
    # 1: {Integer} [0-255] From color.
    # 2: {Integer} [0-255] To color.
    # 3: {Char} (Default: #) Character to print.
    # Out: {String} Colorized line.
    print_colorized_line_background() {
        # Char
        if [ $# -gt 2 ]; then
            local c="$3"
        else
            local c="#"
        fi
        # Print
        for i in {${1}..${2}} {${2}..${1}} ; do
            echo -en "`style background:${i}`${c}"
        done
        # Default
        style default
    }

    # Print at screen.
    #
    # *: {String} Text to print.
    # Out: {String} Text.
    e() {
        local c=`style default`
        echo -e "$@" | sed "s/^/${c}${ECHO_CHAR} /" | sed "s/\t/    /g"
        # Style reset for next command
        echo -ne "\e[0m"
    }

    # Show red alert message.
    #
    # *: {String} Message.
    alert() {
        e
        e "`style color:red` $@"
        e
    }

    # Re-print last line.
    #
    # 1: {Integer} (Default: 1) Lines to meve back. If is not a number, used as text.
    # *: {String} Text to print.
    # Out: {String} Text.
    echo_back() {
        local n=1
        local text="$@"
        if [ $# -gt 1 ]; then
            if is_number "$1" ; then
                n=$1
                text="${@:2}"
            fi
        fi
        local bl="\033[${n}A"
        echo -e "${bl}`style default`${ECHO_CHAR} ${text}`style system`" # Clear line
        str_repeat 80 ' '
    }

    # Pause.
    #
    # *: {String} (Optional) Message.
    pause() {
        if [ $# -le 1 ]; then
            local m="Press any key to continue..."
        else
            local m="$@"
        fi
        e "`style default`"
        read -n 1 -p "${ECHO_CHAR} ${m}"
        e
        e
    }

    # Request user info.
    #
    # 1: {String} (Default: "") Message.
    # 2: {String} (Default: "") Default value.
    # 3: {Integer} (Default: "") Max length for input.
    # 4: {Integer} (Default: "") Timeout.
    # 5: {Boolean} (Default: $FALSE) Silent user output?
    # Result in $RESULT.
    # Return: 0 if valid user input, 1 if cancel, 2 if empty user input and returns default value.
    user_input() {
        # 1: Message
        local m=""
        if [ $# -gt 0 ]; then
            m="${1}"
        fi
        # 2: Default Value
        local d=""
        if [ $# -gt 1 ]; then
            d="${2}"
        fi
        # 3: Max length
        local n=""
        if [ $# -gt 2 ] && is_number "${3}"; then
            n=" -n ${3}"
        fi
        # 4: Timeout
        local t=""
        if [ $# -gt 3 ] && is_number "${4}"; then
            t=" -t ${4}"
        fi
        # 5: Silent outut
        local s=""
        if [ $# -gt 4 ] && [ ${5} == $TRUE ]; then
            s=" -s"
        fi
        # Execute
        local cmd="read${n}${s}${t}"
        ${cmd} -p "`style default`${ECHO_CHAR} ${m}" i
        echo
        local r=$?
        local rta=0
        if [ "${i}" == "$KEY_ESC" ]; then
            rta=1
            i="${d}"
        else
            # 142 == No user input
            if [ "${r}" == "142" ] || [ -z "${i}" ]; then
                # Default value
                rta=2
                i="${d}"
            fi
        fi
        # Result
        RESULT="${i}"
        return ${rta}
    }

    # User confirm.
    #
    # 1: {String} (Optional) Message.
    # 2: {Array} (Default: ( "y" )) Valid options. Case insensitive.
    # 3: {Integer} (Default: $TRUE) Default result on non user input. $TRUE to confirm, $FALSE to no confirm.
    # Return: $TRUE if user confirm, $FALSE if user not confirm.
    user_confirm() {
        # Message
        local m="Confirm? [Y = Yes | N = No]"
        if [ $# -gt 0 ]; then
            m="$1"
        fi
        # Options
        local o=( "y" )
        if [ $# -gt 1 ]; then
            o=($2)
        fi
        # Default
        local d=$FALSE
        if [ $# -gt 2 ]; then
            if [ ${3} == $TRUE ]; then
                d=$TRUE
            else
                d=$FALSE
            fi
        fi
        # Read
        local i=""
        read -n 1 -p "`style default`${ECHO_CHAR} ${m}: " i
        echo
        i=$(trim "$i")
        if [ -z "$i" ]; then
            # Default
            return $d
        else
            # Validate input
            for x in $o; do
                if [ "`str_to_lower "${x}"`" == "`str_to_lower "${i}"`" ]; then
                    # User accept
                    return $TRUE
                fi
            done
        fi
        return 1
    }

    # User confirm.
    #
    # 1: {String} Message.
    # 2: {Array} Options.
    # 3: {Char} (Default: "") Default value on non user input or invalid choice.
    # Result (User input) in $RESULT.
    user_choice() {
        # Message
        local m="$1"
        # Options
        local o=($2)
        # Default
        local d=""
        if [ $# -gt 2 ]; then
            d="$3"
        fi
        # Read
        read -n 1 -p "`style default`${ECHO_CHAR} ${m} [${o}]: " i
        echo
        local RESULT="${d}"
        i=`trim "$i"`
        if [ ! -z $i ]; then
            # Validate input
            for x in $o; do
                if [ "${x}" == "${i}" ]; then
                    # Valid input
                    RESULT="${x}"
                fi
            done
        fi
    }

    # Set on-exit callback.
    #
    # *: Command to execute on APP exit.
    set_on_exit() {
        _ON_EXIT="$@"
    }

    # Exit from APP and execute the function setted in "set_on_exit".
    #
    # 1: {Integer} (Default: 0) Exit code.
    end() {
        if [ "$_APP_EXIT" == "$FALSE" ]; then
            if [ ! -z "$_ON_EXIT" ]; then
                # Execute exit actions
                $_ON_EXIT
            fi
            # Mark as exit
            _APP_EXIT=$TRUE
            # Reset System color
            style reset
            # Space
            echo
            # Exit
            if [ $# -gt 1 ]; then
                exit $1
            else
                exit 0
            fi
        fi
    }
    # On end Script
    trap end EXIT
    # On CTRL + C
    trap end INT

    # Alias of "end".
    die() {
        end $@
    }

    # Time out.
    #
    # 1: {Integer} Time out for count down.
    # 2: {String} Command to execute on count down finish.
    # Return: {Integer} Return command exit code or "255" on user cancel.
    timeout() {
        if [ $# -ne 2 ] || ! is_number "$1" || [ -z "$2" ]; then
            error "Invalid call 'timeout'" 70
        fi
        e
        local COUNT=$1
        local rta=0
        while [ ${COUNT} -gt 0 ] && [ ${rta} -eq 0 ] ; do
            echo_back "Count down [${COUNT}]... Press [C] or [ESC] to cancel..."
            read -n 1 -t 1 -p "" i
            local r=$?
            if [ "${i}" == "c" ] || [ "${i}" == "C" ] || [ "${i}" == "$KEY_ESC" ]; then
                rta=1
            else
                # 142 == No user input
                if [ "${r}" == "142" ]; then
                    let COUNT=COUNT-1
                fi
            fi
        done
        echo_back # Remove last line
        if [ ${COUNT} -eq 0 ]; then
            echo_back
            $2
            return $?
        else
            # Canceled
            echo_back "   Cancel by user!"
            e
            return 255
        fi
    }

    # Print command and their result.
    #
    # 1: {String} Command to print and execute.
    # Out: {String} Command executed and result.
    # Return: Executed command exit code.
    cmd_log() {
        echo
        str_repeat 80 '-'
        echo "$ $1"
        $1
        local r=$?
        str_repeat 80 '-'
        return $r
    }

    # Print APP title and version.
    #
    # Out: APP title and version.
    print_app_info() {
        echo "${APP_TITLE} v${APP_VERSION}"
    }

### DATE / TIME

    # Current time.
    #
    # Out: {String} Time.
    now_time() {
        date '%H:%M:%S'
    }

    # Current date.
    #
    # Out: {String} Date.
    now_date() {
        date '+%Y-%m-%d'
    }

    # Current date and time.
    #
    # Out: {String} Date and time.
    now_date_time() {
        date '+%Y-%m-%d %H:%M:%S'
    }

### TAR

    # Compress file as .tar.gz.
    #
    # 1: {String} Input file.
    # 2: {String} Output file (.tar.gz).
    # Out: {String} Log output.
    # Return: command exit code.
    tar_compress() {
        tar zcvf "$2" "$1"
        return $?
    }

    # Extract .tar.gz file.
    #
    # 1: {String} Input file (.tar.gz).
    # 2: {String} Output path.
    # Out: {String} Log output.
    # Return: command exit code.
    tar_extract() {
        tar zxvf "$1" -C "$2"
        return $?
    }

### FILE / PATH

    # Check if file exists.
    #
    # 1: {String} File path.
    # Return: 0 if file exists, 1 if not exists.
    file_exists() {
        if [ -f "$1" ]; then
            # Exists
            return 0
        else
            # Not exists
            return 1
        fi
    }

    # Get file name.
    #
    # 1: {String} File path.
    # 2: {Boolean} (Default: $FALSE) Remove file extension from file name?
    # Out: {String} File name.
    file_name() {
        # Remove path
        local _fname="`basename "${1}"`"
        if [ "$2" == "$TRUE" ]; then
            # Remove extension
            _fname="`str_replace "${_fname}" "\..*$" ""`"
        fi
        echo ${_fname}
    }

    # Current script file name.
    #
    # Out: {String} Current script file name.
    script_file_name() {
        basename "$0"
    }

    # Script full path.
    #
    # Out: {String} Current script full path.
    script_full_path() {
        echo "$CURRENT_DI/`script_file_name`"
    }

    # Check if directory exists.
    #
    # 1: {String} Directory path.
    # Return: 0 if directory exists, 1 if directory not exists.
    directory_exists() {
        if [ -d `str_escape "$1"` ]; then
            # Exists
            return 0
        else
            # Not exists
            return 1
        fi
    }

    # Wait for file exists.
    #
    # 1: {String} File path.
    # 2: {Integer} (Optional) Time out.
    # Return: 0 if file exists, 1 if file not exists (time-out).
    wait_for_file_exists() {
        local p="..."
        local COUNT=0
        while [ ! -f "$1" ] ; do
            if [ $# -gt 1 ]; then
                if [ $2 -lt $COUNT ]; then
                    # Time out!
                    return 1
                else
                    let COUNT=COUNT+1
                fi
            fi
            echo_back "Waiting for '${1}'${p}"
            sleep 1
            if [ "${p}" == "..." ]; then
                p="."
            else
                p="${p}."
            fi
        done
        # Exists
        return 0
    }

    # Wait for directory exists.
    #
    # 1: {String} Directory path.
    # 2: {Integer} (Optional) Time out.
    # Return: 0 if file exists, 1 if file not exists (time-out).
    wait_for_directory_exists() {
        local p="..."
        local COUNT=0
        while [ ! -d "$1" ] ; do
            if [ $# -gt 1 ]; then
                if [ $2 -gt $COUNT ]; then
                    # Time out!
                    return 1
                else
                    let COUNT=COUNT+1
                fi
            fi
            echo_back "Waiting for '${1}'${p}"
            sleep 1
            if [ "${p}" == "..." ]; then
                p="."
            else
                p="${p}."
            fi
        done
        # Exists
        return 0
    }

    # Check if file contains text.
    #
    # 1: {String} Text to search.
    # 2: {String} File where check.
    # Return: 0 if file contains the text, 1 if not contains the text.
    file_contains() {
        if grep -rils `str_escape "$1"` `str_escape "$2"` &> $DEV_NULL ; then
            # Contains
            return 0
        else
            # Not contains
            return 1
        fi
    }

### EXEC

    # VOID function.
    # Used in empty functions.
    void() {
        echo 0 &> $DEV_NULL
    }

    # Check if all parameters are installed.
    #
    # *: {String} Command to check.
    check_requirements() {
        for req in $@ ; do
            if ! hash "$req" 2>&- ; then
                error "Please install '${req}' to continue."
            fi
        done
    }

    # Print basic usage.
    # Using "__" at begin of function name to set as argument method.
    # Put "#" before function to write extra help text.
    # Special chars: \n, \t (4 spaces)
    #
    # 1: {String} (Default: Current executed file) File to render usage.
    # 2: {String} (Optional) Action to show.
    # Out: {String} Usage text.
    # Use: usage "$0" actionName # For action in current file
    #      usage file.sh actionName # For action in other file
    usage() {
        local src="`script_full_path`"
        local lp="     > "
        local lpl=${#lp}

        if [ $# -gt 0 ] && [ ! -z "$1" ]; then
            src="$1"
            if ! file_exists "${src}" ; then
                src="`script_full_path`"
            fi
        fi

        # Default style
        style default

        if [[ "${src}" =~ \/${SRC_PATH}\/${ACTIONS_DIR}\/.+ ]]; then
            # Action file
            local cmd="`file_name "${src}" $TRUE`"
            if [ $# -lt 2 ] || ([ $# -gt 1 ] && ([ -z "$2" ] || [ "$2" == "$cmd" ] || [ "$2" == "*" ])); then
                local info="`grep "^#\{2\}" "${src}" | sed "s/^#\{2\}\s\?/$(style default)/g" | sed "s/^/$(style default)${lp}/g"`"
                if [ ! -z "$info" ]; then
                    info="|||${info}"
                fi
                e "  bash `style color:red`${0}`style color:green` ${cmd}`style default`${info}" | sed "s/|||.*\s\+>\s/ /g"
                e
            fi
        else
            # USAGE before function
            grep "^\s*\(function\s\+\)\?__.\+()\s*{.*$" "${src}" | while read line ; do
                local cmd=`echo "$line" | sed "s/()\s*{.*//g" | sed "s/\s*\(function\s\+\)\?__//g"`
                if [ $# -lt 2 ] || ([ $# -gt 1 ] && ([ -z "$2" ] || [ "$2" == "$cmd" ] || [ "$2" == "*" ])); then
                    local info=`grep -C0 -A0 -B1 "^\s*\(function\s\+\)\?__$cmd\s*()\s*{" "$src" | sed "N;s/\n.*//g" | sed "s/^\s*#\s*/$(style default)/g" | sed "s/\s*\\\n/\n$(style default)${ECHO_CHAR}     > /g" | sed "s/\\\t/    /g"`
                    info="`echo -e "$info" | sed "s/^/${lp}/"`"
                    e "  bash `style color:red`${0}`style color:green` ${cmd}`style default` ${info:$lpl}"
                    e
                fi
            done
        fi
    }

    #[action]\nPrint basic usage (this).\nParams:\n  action: Action Name. Display action usage.
    __usage() {
        e
        e "Usage:"
        e
        # Base file
        usage "`script_file_name`" "$1"
        # Actions
        if [ -d "${ACTIONS_PATH}" ]; then
            for f in ${ACTIONS_PATH}/* ; do
                if [ -f "${f}" ]; then
                    usage "${f}" "$1"
                fi
            done
        fi
        # BashX
        if [ "`script_file_name`" != "${BASHX_CURRENT_SOURCE}" ]; then
            usage "${BASHX_CURRENT_SOURCE}" "$1"
        fi
    }

    #[action]\nAlias of "usage", with less.\nParams:\n  action: Action Name. Display action usage.
    __help() {
        check_requirements less
        __usage "$@" | less -r
        # Clear output
        clear
    }

    # Run APP.
    # Run arguments as commands if any, or show "usage".
    #
    # See "usage" to see how to use.
    #
    # Use: At end of file, put next:
    #   run "$@"
    run() {
        local APPINFO=" $(print_app_info) "
        local APPINFOB="+-$(str_repeat $(str_len "${APPINFO}") "-")-+"
        local r=1
        echo
        e "${APPINFOB}"
        e "| ${APPINFO} |"
        e ${APPINFOB}
        e

        # Check requeirements
        check_requirements "${APP_REQUEIREMENTS}"

        if [ $# -gt 0 ]; then

            # Load actions
            if [ -d "${ACTIONS_PATH}" ]; then
                for __fn__path__ in ${ACTIONS_PATH}/* ; do
                    if [ -f "${__fn__path__}" ]; then
                        # Create action function
                        eval "__$(file_name "${__fn__path__}" $TRUE)() { . ${__fn__path__}; }"
                    fi
                done
            fi

            # If function exists
            if function_exists "__$1" ; then
                # Exec
                if [ "$1" == "help" ]; then
                    ACTION="usage"
                else
                    ACTION="$1"
                fi
                __"$@"
                r=$?
            else
               error "Parameter '$(style color:green)${1}$(style color:red)' not found. Call 'usage' to see help."
            fi
        fi
        if [ ${#1} == 0 ]; then
            if [ -z "${DEFAULT_ACTION}" ]; then
                # Show usage
                ACTION="usage"
                __usage
                r=1
            else
                # Call default action
                ACTION="$DEFAULT_ACTION"
                __${DEFAULT_ACTION}
            fi
        fi
        # Return result code
        end $r
    }

# #############################################################################
