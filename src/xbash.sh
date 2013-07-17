#!/bin/bash

## XBash
##
## Extended Bash Framework.
##
## Version: 1.3
## URL: https://github.com/reduardo7/xbash
##
## Author: Eduardo Cuomo | eduardo.cuomo.ar@gmail.com

# #############################################################################

# Init.

## #!/bin/bash
## . ./src/xbash.sh

# #############################################################################

# Test if running with "bash" interpreter.
if [ -z "$BASH" ]; then
    bash "$0" "$@"
    exit $?
fi

# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\e[0m"' DEBUG

# #############################################################################

### CONFIG
# Rewrite with your configuration.

    # APP Title.
    APP_TITLE="XBash"

    # APP Version.
    APP_VERSION="1.3"

    # Default APP color. See "ecolor" for more information.
    #COLOR_DEFAULT="system" # Default system color
    COLOR_DEFAULT="cyan"

    # Start character for formated print screen (see "e" function).
    ECHO_CHAR="#"

    # Application requeirements.
    # To extend requeirements, use:
    #   APP_REQUEIREMENTS="${APP_REQUEIREMENTS} other app command extra foo"
    APP_REQUEIREMENTS="echo printf sed grep tput read date dirname readlink basename tar let"

    # Default action to call
    # Action to use if script called without arguments.
    DEFAULT_ACTION=""

    # XBash SRC path.
    XBASH_SRC_PATH="src"

### Load files

    # Config
    if [ -z "${CONFIG_FILE}" ]; then
        # Default file
        CONFIG_FILE="${XBASH_SRC_PATH}/config.ini"
    fi
    if [ -f "${CONFIG_FILE}" ]; then
        # Load file
        . ./${CONFIG_FILE}
    fi

### VARS

    # Current path
    CURRENT_DIR="$(pwd)"

    # XBash File Name
    XBASH_FILE_NAME="./${XBASH_SRC_PATH}/xbash.sh"

    # Null path.
    DEV_NULL="/dev/null"

    # Boolean true.
    TRUE=1

    # Boolean false.
    FALSE=0

    # Key: ESC
    KEY_ESC=$'\e'

    # Result value for some functions
    RESULT=""

    # Called action
    ACTION=""

    # Actions directory name
    ACTIONS_DIR="actions"

    # Actions path
    ACTIONS_PATH="./${XBASH_SRC_PATH}/${ACTIONS_DIR}"

### PRIVATE VARS

    # On exit command
    _ON_EXIT=''

   # TRUE if APP is terminated
   _APP_EXIT=$FALSE

### UTILS

    # Check if run as Root.
    #
    # Out: {Boolean} TRUE if is root.
    # Return: 0 if is root, 1 is not root.
    function is_root() {
        # Is ROOT user?
        if [ "$(id -u)" -ne 0 ]; then
            # No Root
            echo $FALSE
            return 1
        else
            # Root
            echo $TRUE
            return 0
        fi
    }

    # Check if running as ROOT, or exit from script.
    #
    # *: (Optional) Message.
    function root_validator() {
        if [ "$(is_root)" == $FALSE ]; then
            if [ $# -eq 0 ] ; then
                m="This script must be run as root!"
            else
                m="$@"
            fi
            e "$m"
            e
            end 1
        fi
    }

    # Check if is empty.
    #
    # 1: {*} Variable to check if emtpy.
    # Out: {Boolean} TRUE if variable is emtpy.
    # Return: The same as "Out".
    function is_empty() {
        if [ -z "$1" ]; then
            # Empty
            echo $TRUE
        else
            # No empty
            echo $FALSE
        fi
    }

    # Check if is a number.
    #
    # 1: {*} Variable to check if is a number.
    # Out: {Boolean} TRUE if variable is a number.
    # Return: 0 if variable is a number, 1 if variable is not a number.
    function is_number() {
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            echo $TRUE
            return 0
        else
            echo $FALSE
            return 1
        fi
    }

    # Check if function exists.
    #
    # 1: {String} Function name.
    # Out: {Boolean} TRUE if function exists.
    # Return: 0 if function exists, 0 if file not exists.
    function function_exists() {
        declare -f "$1" > /dev/null
        if [ $? -eq 0 ]; then
            echo $TRUE
            return 0
        else
            echo $FALSE
            return 1
        fi
    }

    # Print vars.
    #
    # *: Vars to print.
    function xdie() {
        echo
        echo "## XDIE ##"
        echo
        echo $@
        echo
        end 1
    }

### STRING

    # Escape string for Bash.
    #
    # *: {String} String to escape for Bash.
    # Out: {String} Escaped string.
    function str_escape() {
        printf '%q' "$@"
    }

    # Repeat string.
    #
    # 1: {Integer} Number of repetitions.
    # 2: {String} String to repeat.
    # Out: {String} Repeated string.
    function str_repeat() {
        let fillsize=$1
        fill=$2
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
    function str_replace() {
        options="g"
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
    function str_explode() {
        IFS="$1"
        RESULT=( $(echo "$2") )
        return ${#RESULT[@]}
    }

    # Trim text.
    #
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    function trim() {
        chr=" "
        if [ $# -gt 1 ]; then
            chr="$2"
        fi
        echo "$1" | sed "s/^${chr}//g" | sed "s/${chr}$//g"
    }

    # Left trim text.
    #
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    function ltrim() {
        chr=" "
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
    function rtrim() {
        chr=" "
        if [ $# -gt 1 ]; then
            chr="$2"
        fi
        echo "$1" | sed "s/${chr}$//g"
    }

    # String length.
    #
    # 1: {String} Text.
    # Out: {Integer} String length.
    function str_len() {
        echo ${#1}
    }

    # Sub string.
    # 1: {String} String to cut.
    # 2: {Integer} Limit.
    # 3: {Integer} (Optional) Offset.
    # Out: {String} Result string
    function sub_str() {
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
    # Return: 0 on fonud, 1 on not found.
    function str_pos() {
        if [ $# -lt 3 ] || [ $3 = $TRUE ]; then
            # Case sensitive
            p="-bo"
        else
            # Case insensitive
            p="-boi"
        fi
        r=$(echo "$1" | grep $p "$2" | sed 's/:.*$//')
        echo $r
        if [ $(is_empty "$r") = $FALSE ]; then
            # Found
            return 0
        else
            # No found
            return 1
        fi
    }

    # String contains substring?
    #
    # 1: {String} String where search.
    # 2: {String} Substring to search.
    # 3: {Boolean} (Default: TRUE) TRUE for case sensitive.
    # Out: {Boolean} TRUE if contains substring.
    # Return: TRUE if contains substring.
    function in_str() {
        if [ $# -lt 3 ]; then
            str_pos "$1" "$2" > $DEV_NULL
            local r=$?
        else
            str_pos "$1" "$2" "$3" > $DEV_NULL
            local r=$?
        fi
        echo $r
        return $r
    }

### ERROR

    # Last execution returns > 0 (error)?
    #
    # 1: {String} Command to execute on error.
    # 2: {Integer} Change exit code.
    function check_error() {
        c=$?
        if [ $c -ne 0 ]; then
            # Error
            $1
            if [ $# -gt 1 ]; then
                c=$2
            fi
            error "" $c
        fi
    }

    # Show error message and exit.
    #
    # 1: {String} Error message.
    # 2: {Integer} (Default: 1) Exit code.
    function error() {
        if ! [ -z "$1" ]; then
            e
            e "$(ecolor red)Error! $1"
        fi
        e
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
    function screen_width() {
        tput cols
    }

    # Change screen print color.
    #
    # 1: {COLOR} Color. See "case" into this function for details.
    # 2: {String} (Default: Default Color) Text to print.
    # Out: {String} Text.
    # Use: e "normal color $(ecolor red)text in red $(ecolor black)black color"
    function ecolor() {
        c=""
        case "$1" in
            default) # Default APP color
                c=""
                ;;
            system) # System color
                c="0"
                ;;
            black)
                c="0;30"
                ;;
            white)
                c="1;37"
                ;;
            gray)
                c="0;37"
                ;;
            gray_light)
                c="1;30"
                ;;
            blue)
                c="0;34"
                ;;
            blue_light)
                c="1;34"
                ;;
            green)
                c="0;32"
                ;;
            green_light)
                c="1;32"
                ;;
            cyan)
                c="0;36"
                ;;
            cyan_light)
                c="1;36"
                ;;
            red)
                c="0;31"
                ;;
            red_light)
                c="1;31"
                ;;
            purple)
                c="0;35"
                ;;
            purple_light)
                c="1;35"
                ;;
            coffe)
                c="0;33"
                ;;
            yellow)
                c="1;33"
                ;;
        esac
        if [ -z "${c}" ]; then
            ecolor "${COLOR_DEFAULT}"
        else
            echo "\e[${c}m"
        fi
    }

    function style() {
        FONT_BOLD=`tput bold`
        FONT_UNDERLINE_ON=`tput smul`
        FONT_UNDERLINE_OFF=`tput rmul`
        # FONT_TEXT_BLACK=`tput setaf 0`
        # FONT_TEXT_RED=`tput setaf 1`
        # FONT_TEXT_GREEN=`tput setaf 2`
        # FONT_TEXT_YELLOW=`tput setaf 3`
        # FONT_TEXT_BLUE=`tput setaf 4`
        # FONT_TEXT_MAGENTA=`tput setaf 5`
        # FONT_TEXT_CYAN=`tput setaf 6`
        # FONT_TEXT_WHITE=`tput setaf 7`
        FONT_BACKGROUND_BLACK=`tput setab 0`
        FONT_BACKGROUND_RED=`tput setab 1`
        FONT_BACKGROUND_GREEN=`tput setab 2`
        FONT_BACKGROUND_YELLOW=`tput setab 3`
        FONT_BACKGROUND_BLUE=`tput setab 4`
        FONT_BACKGROUND_MAGENTA=`tput setab 5`
        FONT_BACKGROUND_CYAN=`tput setab 6`
        FONT_BACKGROUND_WHITE=`tput setab 7`
        FONT_RESET_FORMATTING=`tput sgr0`

        for p in $@ ; do
            # Color
            if [[ "$p" =~ ^color\s*\=\s*.+$ ]]; then

                case "$s" in
                    default)
                        tput sgr0
                        ;;
                    black)
                        tput setab 0
                        ;;
                    white)
                        tput setaf 7
                        ;;
                    blue)
                        tput setaf 4
                        ;;
                    green)
                        tput setaf 2
                        ;;
                    cyan)
                        tput setaf 6
                        ;;
                    red)
                        tput setaf 1
                        ;;
                    yellow)
                        tput setaf 3
                        ;;
                    magenta)
                        tput setaf 5
                        ;;
                esac
            fi
        done
    }

    # Print at screen.
    #
    # *: {String} Text to print.
    # Out: {String} Text.
    function e() {
        c="$(ecolor default)"
        echo -e "${c}${ECHO_CHAR} $@${c}"
    }

    # Print a text using color.
    #
    # 1: {COLOR} Color. See "case" into "ecolor" function for details.
    # *: {String} Text to print.
    # Out: {String} Text.
    function ec() {
        echo -e "$(ecolor $1)${@:2}$(ecolor system)"
    }

    # Re-print last line.
    #
    # 1: {Integer} (Default: 1) Lines to meve back. If is not a number, used as text.
    # *: {String} Text to print.
    # Out: {String} Text.
    function echo_back() {
        n=1
        text="$@"
        if [ $# -gt 1 ]; then
            if [ $(is_number "$1") = $TRUE ]; then
                n=$1
                text="${@:2}"
            fi
        fi
        bl="\033[${n}A"
        echo -e "${bl}$(ecolor default)${ECHO_CHAR} ${text}$(ecolor system)" # Clear line
        str_repeat 80 ' '
    }

    # Pause.
    #
    # *: {String} (Optional) Message.
    function pause() {
        if [ $# -le 1 ]; then
            m="Press any key to continue..."
        else
            m="$@"
        fi
        e "$(ecolor default)"
        read -n 1 -p "${ECHO_CHAR} ${m}"
        e
        e
    }

    # Set on-exit callback.
    #
    # *: Command to execute on APP exit.
    function set_on_exit() {
         _ON_EXIT="$@"
    }

    # Exit from APP and execute the function setted in "set_on_exit".
    #
    # 1: {Integer} (Default: 0) Exit code.
    function end() {
        if [ "$_APP_EXIT" == "$FALSE" ]; then
            if [ ! -z "$_ON_EXIT" ]; then
                $_ON_EXIT
            fi
            _APP_EXIT=$TRUE
            e $(ecolor system)
            echo
            if [ $# -gt 1 ]; then
                exit $1
            else
                exit 0
            fi
        fi
    }
    # CTRL + C
    trap end EXIT

    # Time out.
    #
    # 1: {Integer} Time out for count down.
    # 2: {String} Command to execute on count down finish.
    # Return: {Integer} Return command exit code or "255" on user cancel.
    function timeout() {
        if [ $# -ne 2 ] || [ $(is_number "$1") -eq $FALSE ] || [ -z "$2" ]; then
            error "Invalid call 'timeout'" 70
        fi
        e
        COUNT=$1
        rta=0
        while [ ${COUNT} -gt 0 ] && [ ${rta} -eq 0 ] ; do
            echo_back "Count down [${COUNT}]... Press [C] or [ESC] to cancel..."
            read -n 1 -t 1 -p "" i
            r=$?
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
    function cmd_log() {
        echo
        str_repeat 80 '-'
        $1
        r=$?
        str_repeat 80 '-'
        return $r
    }

    # Print APP title and version.
    #
    # Out: APP title and version.
    function print_app_info() {
        echo "${APP_TITLE} v${APP_VERSION}"
    }

### DATE / TIME

    # Current time.
    #
    # Out: {String} Time.
    function now_time() {
        date '%H:%M:%S'
    }

    # Current date.
    #
    # Out: {String} Date.
    function now_date() {
        date '+%Y-%m-%d'
    }

    # Current date and time.
    #
    # Out: {String} Date and time.
    function now_date_time() {
        date '+%Y-%m-%d %H:%M:%S'
    }

### TAR

    # Compress file as .tar.gz.
    #
    # 1: {String} Input file.
    # 2: {String} Output file (.tar.gz).
    # Out: {String} Log output.
    function tar_compress() {
        tar zcvf "$2" "$1"
        return $?
    }

    # Extract .tar.gz file.
    #
    # 1: {String} Input file (.tar.gz).
    # 2: {String} Output path.
    # Out: {String} Log output.
    function tar_extract() {
        tar zxvf "$1" -C "$2"
        return $?
    }

### FILE / PATH

    # Check if file exists.
    #
    # 1: {String} File path.
    # Out: {Boolean} TRUE if file exists, 0 if not exists.
    # Return: 0 if file exists, 1 if not exists.
    function file_exists() {
        if [ -f "$1" ]; then
            # Exists
            echo $TRUE
            return 0
        else
            # Not exists
            echo $FALSE
            return 1
        fi
    }

    # Get file name.
    #
    # 1: {Boolean} (Default: FALSE) Remove file extension from file name?
    # Out: {String} File name.
    function file_name() {
        # Remove path
        local _fname="$(str_replace "${f}" "^.*\/" "")"
        if [ "$2" == "$TRUE" ]; then
            # Remove extension
            local _fname="$(str_replace "${_fname}" "\..*$" "")"
        fi
        echo ${_fname}
    }

    # Current directory.
    #
    # Out: {String} Current directory.
    function current_directory() {
        dirname "$(readlink -f "$0")"
    }

    # Current script file name.
    #
    # Out: {String} Current script file name.
    function script_file_name() {
        basename "$0"
    }

    # Script full path.
    #
    # Out: {String} Current script full path.
    function script_full_path() {
        echo "$(current_directory)/$(script_file_name)"
    }

    # Check if directory exists.
    #
    # 1: {String} Directory path.
    # Out: {Boolean} TRUE if directory exists, FALSE if not exists.
    # Return: 0 if directory exists, 1 if not exists.
    function directory_exists() {
        if [ -d $(str_escape "$1") ]; then
            # Exists
            echo $TRUE
            return 0
        else
            # Not exists
            echo $FALSE
            return 1
        fi
    }

    # Wait for file exists.
    #
    # 1: {String} File path.
    # 2: {Integer} (Optional) Time out.
    # Return: 0 if file exists, 1 if file not exists (time-out).
    function wait_for_file_exists() {
        p="..."
        COUNT=0
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
    function wait_for_directory_exists() {
        p="..."
        COUNT=0
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
    # Out: {Boolean} TRUE if file contains the text, FALSE if not contains the text.
    # Return: 0 if file contains the text, 1 if not contains the text.
    function file_contains() {
        grep -rils $(str_escape "$1") $(str_escape "$2") > /dev/null
        if [ $? -eq 1 ]; then
            # Not contains
            echo $FALSE
            return 1
        else
            # Contains
            echo $TRUE
            return 0
        fi
    }

### EXEC

    # VOID function.
    # Used in empty functions.
    function void() {
        echo 0 > $DEV_NULL
    }

    # Check if all parameters are installed.
    #
    # *: {String} Command to check.
    function check_requirements() {
        for req in $@ ; do
            hash "$req" 2>&-
            if [ $? == 1 ]; then
                error "Error! Please install '${req}' to continue."
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
    function usage() {
        local src="$(script_full_path)"
        if [ $# -gt 0 ] && [ ! -z "$1" ]; then
            local src="$1"
            if [ $(file_exists "${src}") == $FALSE ]; then
                local src="$(script_full_path)"
            fi
        fi


        if [[ "${src}" =~ \/${XBASH_SRC_PATH}\/${ACTIONS_DIR}\/.+ ]]; then
            # Action file
            local cmd="$(file_name "${src}" $TRUE)"
            if [ $# -lt 2 ] || ([ $# -gt 1 ] && ([ -z "$2" ] || [ "$2" == "$cmd" ] || [ "$2" == "*" ])); then
                local info="$(grep "^##" "${src}" | sed "s/^##\s\?/$(str_escape "$(ecolor default)")/g" | sed "s/^/$(str_escape "$(ecolor default)")${ECHO_CHAR}     > /g" | sed "s/\t/    /g" | sed "s/^------------------/  -----  /g")"
                local divisor="|!|"
                e "  bash $(ecolor red)${0}$(ecolor blue) ${cmd}$(ecolor default)${divisor}${info}" | sed "s/${divisor}.\+${ECHO_CHAR}\s\+>\s/ /g"
                e
            fi
        else
            # USAGE before function
            grep "^\s*\(function\s\+\)\?__.\+()\s*{.*$" "${src}" | while read line ; do
                local cmd=$(echo "$line" | sed "s/()\s*{.*//g" | sed "s/\s*\(function\s\+\)\?__//g")
                if [ $# -lt 2 ] || ([ $# -gt 1 ] && ([ -z "$2" ] || [ "$2" == "$cmd" ] || [ "$2" == "*" ])); then
                    local info="$(grep -C0 -A0 -B1 "^\s*\(function\s\+\)\?__$cmd\s*()\s*{" "$src" | sed "N;s/\n.*//g" | sed "s/^\s*#\s*/$(str_escape "$(ecolor default)")/g" | sed "s/\s*\\\n/\n$(str_escape "$(ecolor default)")${ECHO_CHAR}     > /g" | sed "s/\\\t/    /g")"
                    e "  bash $(ecolor red)${0}$(ecolor blue) ${cmd}$(ecolor default) ${info}"
                    e
                fi
            done
        fi
    }

    # Print usage
    #time command\nPrint basic usage (this).\nAdd action name to display the action usage.
    function __usage() {
        e
        e "Usage:"
        e
        # Base file
        usage "$(script_file_name)" "$1"
        # Actions
        if [ -d "${ACTIONS_PATH}" ]; then
            for f in ${ACTIONS_PATH}/* ; do
                if [ -f "${f}" ]; then
                    usage "${f}" "$1"
                fi
            done
        fi
        # XBash
        if [ "$(script_file_name)" != "${XBASH_FILE_NAME}" ]; then
            usage "${XBASH_FILE_NAME}" "$1"
        fi
    }

    # Alias of "usage", with less.
    function __help() {
        check_requirements less
        __usage "$@" | less
    }

    # Run APP.
    # Run arguments as commands if any, or show "usage".
    #
    # See "usage" to see how to use.
    #
    # Use: At end of file, put next:
    #   run "$@"
    function run() {
        APPINFO=" $(print_app_info) "
        local APPINFOB="+-$(str_repeat $(str_len "${APPINFO}") "-")-+"
        local r=1
        echo
        e ${APPINFOB}
        e "| ${APPINFO} |"
        e ${APPINFOB}
        e
        # Check requeirements
        check_requirements "${APP_REQUEIREMENTS}"
        if [ $# -gt 0 ]; then
            if [ $(function_exists "__$1") == $TRUE ]; then
                # Exec
                if [ "$1" == "help" ]; then
                    ACTION="usage"
                else
                    ACTION="$1"
                fi
                __"$@"
                local r=$?
            else
                error "Parameter '$(ecolor blue)${1}$(ecolor red)' not found. Call 'usage' to see help."
            fi
        fi
        if [ ${#1} == 0 ]; then
            if [ -z "${DEFAULT_ACTION}" ]; then
                # Show usage
                ACTION="usage"
                __usage
                local r=1
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
