#!/bin/bash

## XBash
##
## Bash Extension.
##
## Version: 1.0
## URL: https://github.com/reduardo7/xbash
##
## Author: Eduardo Cuomo | eduardo.cuomo.ar@gmail.com

# #############################################################################

# Init.

## #!/bin/bash
## . ./xbash.sh

# #############################################################################

# Test if running with "bash" interpreter.
if [ "$BASH" = "" ] ; then
    bash $0 "$@"
    exit $?
fi

# #############################################################################

### CONFIG
# Rewrite with your configuration.

    # APP Title.
    APP_TITLE="XBash"
    
    # APP Version.
    APP_VERSION="1.0"
    
    # Default APP color. See "ecolor" for more information.
    #COLOR_DEFAULT="system" # Default system color
    COLOR_DEFAULT="cyan"
    
    # Start character for formated print screen (see "e" function).
    ECHO_CHAR="#"
    
    # Application requeirements.
    # To extend requeirements, use:
    #   APP_REQUEIREMENTS="${APP_REQUEIREMENTS} other app command extra foo"
    APP_REQUEIREMENTS="echo printf sed grep tput read date dirname readlink basename tar"

### VARS

    # Null path.
    DEV_NULL="/dev/null"
    
    # Boolean true.
    TRUE=1
    
    # Boolean false.
    FALSE=0

### UTILS

    # Check if run as Root.
    #
    # Out: {Boolean} TRUE if is root.
    # Return: The same as "Out".
    function is_root() {
        # Is ROOT user?
        if [ "$(id -u)" -ne 0 ]; then
            # No Root
	        echo $FALSE
	        return $FALSE
        else
            # Root
            echo $TRUE
            return $TRUE
        fi
    }
    
    # Last execution returns > 0?
    #
    # 1: {String} Command on error.
    # 2: {String} Command on success.
    # Return: Returns 1 on error.
    function check_error() {
        if [ $? -ne 0 ] ; then
            # Error
            $1
            return $TRUE
        else
            # Success
            if [ $# -gt 1 ] ; then
                $2
            fi
            return $FALSE
        fi
    }

    # Check if is empty.
    #
    # 1: {*} Variable to check if emtpy.
    # Out: {Boolean} TRUE if variable is emtpy.
    # Return: The same as "Out".
    function is_empty() {
        if [ -z "$1" ] ; then
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
    # Return: The same as "Out".
    function is_number() {
        if [[ "$1" =~ ^[0-9]+$ ]] ; then
            echo $TRUE
            return $TRUE
        else
            echo $FALSE
            return $FALSE
        fi
    }
    
    # Check if function exists.
    #
    # 1: {String} Function name.
    # Out: {Boolean} TRUE if function exists.
    # Return: {Boolean} TRUE if function exists.
    function function_exists() {
        declare -f "$1" > /dev/null
        if [ $? -eq 0 ] ; then
            echo $TRUE
            return $TRUE
        else
            echo $FALSE
            return $FALSE
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
        exit 1
    }

### STRING

    # Escape string for Bash.
    #
    # 1: {String} String to escape for Bash.
    # Out: {String} Escaped string.
    function str_escape() {
	    printf '%q' "$1"
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
        if [ $# -lt 4 ] || [ "$4" -ne $TRUE ] ; then
            options="${options}i"
        fi
        echo "$1" | sed "s/$2/$3/$options"
    }
    
    # Trim text.
    #
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    function trim() {
        chr=" "
        if [ $# -gt 1 ] ; then
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
        if [ $# -gt 1 ] ; then
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
        if [ $# -gt 1 ] ; then
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
        if [ $# -eq 2 ] ; then
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
    # Return: TRUE on fonud, FALSE on not found.
    function str_pos() {
        if [ $# -lt 3 ] || [ $3 = $TRUE ] ; then
            # Case sensitive
            p="-bo"
        else
            # Case insensitive
            p="-boi"
        fi
        r=$(echo "$1" | grep $p "$2" | sed 's/:.*$//')
        echo $r
        if [ $(is_empty "$r") = $FALSE ] ; then
            # Found
            return $TRUE
        else
            # No found
            return $FALSE
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
        if [ $# -lt 3 ] ; then
            str_pos "$1" "$2" > $DEV_NULL
            r=$?
        else
            str_pos "$1" "$2" "$3" > $DEV_NULL
            r=$?
        fi
        echo $r
        return $r
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
            gray2)
                c="1;30"
                ;;
            blue)
                c="0;34"
                ;;
            blue2)
                c="1;34"
                ;;
            green)
                c="0;32"
                ;;
            green2)
                c="1;32"
                ;;
            cyan)
                c="0;36"
                ;;
            cyan2)
                c="1;36"
                ;;
            red)
                c="0;31"
                ;;
            red2)
                c="1;31"
                ;;
            purple)
                c="0;35"
                ;;
            purple2)
                c="1;35"
                ;;
            coffe)
                c="0;33"
                ;;
            yellow)
                c="1;33"
                ;;
        esac
        if [ -z "${c}" ] ; then
            ecolor "${COLOR_DEFAULT}"
        else
            echo "\e[${c}m"
        fi
    }
     
    # Print at screen.
    #
    # *: {String} Text to print.
    # Out: {String} Text.
    function e() {
        echo -e "$(ecolor default)${ECHO_CHAR} $@$(ecolor system)"
    }
    
    # Re-print last line.
    #
    # 1: {String} Text to print.
    # 2: {Integer} (Default: 1) Lines to meve back.
    # Out: {String} Text.
    function eb() {
        n=1
        if [ $# -gt 1 ] ; then
            n=$2
        fi
        bl="\033[${n}A"
        c="$(ecolor default)"
        print_line " " "${bl}${c}${ECHO_CHAR} $@${c}" # Clear line
    }

    # Pause.
    #
    # 1: {String} Message.
    function pause() {
        if [ $# -le 1 ] ; then
            m="Press any key to continue..."
        else
            m="$@"
        fi
        e "$(ecolor default)"
        read -n 1 -p "${ECHO_CHAR} ${m}"
        e
        e
    }
    
    # Show error message and exit.
    #
    # 1: {String} Error message.
    # 2: {Integer} (Default: 1) Error code.
    function exit_error() {
        e
        e "$(ecolor red)Error!"
        e "$(ecolor red)$1"
        e
        if [ $# -gt 1 ] ; then
            exit $2
        else
            exit 1
        fi
    }
    
    # Time out.
    #
    # 1: {Integer} Time out for count down.
    # 2: {String} Command to execute on count down finish.
    # Return: {Integer} Return command exit code or "255" on user cancel.
    function timeout() {
        if [ $# -ne 2 ] || [ $(is_number "$1") -eq $FALSE ] || [ -z "$2" ]; then
            exit_error "Invalid call 'timeout'" 70
        fi
        e
        COUNT=$1
        rta=0
        while [ ${COUNT} -gt 0 ] && [ ${rta} -eq 0 ] ; do
            eb "Count down... ${COUNT}    Press [C] to cancel..." 
            read -n 1 -t 1 -p "" i
            r=$?
            if [ "${i}" == "c" ] || [ "${i}" == "C" ] ; then
                rta=1
            else
                # 142 == No user input
                if [ "${r}" == "142" ] ; then
                    let COUNT=COUNT-1
                fi
            fi
        done
        if [ ${COUNT} -eq 0 ] ; then
            e
            $2
            return $?
        else
            # Canceled
            e
            e "   Cancel by user!"
            e
            return 255
        fi
    }
    
    # Print a line with full width.
    #
    # 1: {Char} Character for line.
    # 2: {String} (Optional) Text to print at start.
    # Out: {String} Line.
    function print_line() {
        if [ $# -eq 0 ] ; then
            # No params
            len=0
            fill=""
            c="-"
            lenC=1
        else
            # Character
            c="$1"
            lenC=$(str_len "$c")
            len=0
            if [ $# -eq 2 ] ; then
                # Text
                let len=$(str_len "$2")+1
                fill="$2 "
            fi
        fi
        let fillsize=$(screen_width)-${len}
        while [ ${fillsize} -gt 0 ] ; do
            fill="${fill}${c}"
            let fillsize=${fillsize}-${lenC}
        done
        echo -e "${fill}"
    }
    
    # Print command and their result.
    #
    # 1: {String} Command to print and execute.
    # Out: {String} Command executed and result.
    # Return: Executed command exit code.
    function cmd_log() {
        echo
        print_line "-" "$1"
        $1
        r=$?
        print_line
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
    # Return: The same as "Out".
    function file_exists() {
        if [ -f "$1" ]; then
            # Exists
            echo $TRUE
            return $TRUE
        else
            # Not exists
            echo $FALSE
            return $FALSE
        fi
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
    # Out: {Boolean} TRUE if directory exists, 0 if not exists.
    # Return: The same as "Out".
    function path_exists() {
        if [ -d $(str_escape "$1") ]; then
            # Exists
            echo $TRUE
            return $TRUE
        else
            # Not exists
            echo $FALSE
            return $FALSE
        fi
    }

    # Check if file contains text.
    #
    # 1: {String} Text to search.
    # 2: {String} File where check.
    # Out: {Boolean} TRUE if file contains the text, 0 if not contains the text.
    # Return: The same as "Out".
    function file_contains() {
        grep -rils $(str_escape "$1") $(str_escape "$2") > /dev/null
        if [ $? -eq 1 ]; then
            # Not contains
            echo $FALSE
            return $FALSE
        else
            # Contains
            echo $TRUE
            return $TRUE
        fi
    }

### EXEC

    # Check if all parameters are installed.
    #
    # 1: {String} Commands separated by spaces.
    function check_requirements() {
        for req in $@ ; do
            hash "$req" 2>&-
            if [ $? == 1 ] ; then
                exit_error "Error! Please install '${req}' to continue."
            fi
        done
    }
    
    # Print basic usage.
    # Using "__" at begin of function name to set as argument method.
    # Put "#" before function to write extra help text.
    # Special chars:
    #   %n -> \n
    #   %t -> \t (4 spaces)
    #
    # 1: {String} (Default: Current executed file) File to render usage.
    # Out: {String} Usage text.
    function __usage() { #%nPrint basic usage (this).
        if [ $# -gt 0 ] ; then
            src="$1"
            if [ $(file_exists "${src}") == $FALSE ] ; then
                src="$(script_full_path)"
            fi
        else
            src="$(script_full_path)"
        fi
        grep "^[ \t]*function __.\+()[ \t]*{.*$" "${src}" | while read line ; do
            e "  \$$(ecolor red)$0$(ecolor blue) $(echo "${line}" | sed "s/()[ \t]*{.*#[ \t]*/ $(str_escape "$(ecolor default)")/g")" | sed "s/()[ \t]*{[ \t]*//g" | sed "s/[ \t]*function __/ /g" | sed "s/[ \t]*%n/\n${ECHO_CHAR}     > /g" | sed "s/%t/    /g"
            e
        done
    }
    
    # Alias of "usage".
    function __help() { #%nAlias of "usage".
        __usage "$@"
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
        APPINFOB="+-$(str_repeat $(str_len "${APPINFO}") "-")-+"
        r=1
        echo
        e ${APPINFOB}
        e "| ${APPINFO} |"
        e ${APPINFOB}
        e
        # Check requeirements
        check_requirements "${APP_REQUEIREMENTS}"
        if [ $# -gt 0 ] ; then
            if [ $(function_exists "__$1") == $TRUE ] ; then
                # Exec
                __"$@"
                r=$?
            else
                exit_error "Parameter '$(ecolor blue)${1}$(ecolor red)' not found. Call 'usage' to see help."
            fi
        fi
        if [ ${#1} == 0 ] ; then
            e "$CMDS"
            e "Usage:"
            e
            __usage
            if [ "$(script_file_name)" != "xbash.sh" ] ; then
                __usage "xbash.sh"
            fi
            r=1
        fi
        e
        echo
        # Return result code
        exit $r
    }

# #############################################################################
