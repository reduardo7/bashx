#!/bin/bash

# Bash Extension.
#
# Version: 1.0
# URL: https://github.com/reduardo7/xbash
#
# Eduardo Cuomo | eduardo.cuomo.ar@gmail.com

##############################################################################

# Call:
# > source xbash.sh

##############################################################################

# Test if running with "bash" interpreter.
if [ "$BASH" = "" ] ; then
    _BASH_RECALL=""
    for a in "$@" ; do
        _BASH_RECALL="$_BASH_RECALL $a"
    done
    # Run with "bash"
    _BASH_RECALL="bash $0 $_BASH_RECALL"
    $_BASH_RECALL
    # Exit
    exit $?
fi

##############################################################################

### VARS ###

    # Null path
    DEV_NULL="/dev/null"

    # Screen width
    SCR_WIDTH=$(tput cols)

### TOOLS ###

    # Check if run as Root.
    # Out: {Boolean} 1 if is root.
    # Return: The same as "Out".
    function is_root() {
        # Is ROOT user?
        if [ "$(id -u)" -ne 0 ]; then
            # No Root
	        echo 0
	        return 0
        else
            # Root
            echo 1
            return 1
        fi
    }
    
    # Last execution returns > 0?
    # 1: {String} Command on error.
    # 2: {String} Command on success.
    # Return: {Boolean} Returns 1 on error.
    function check_error() {
        if [ $? -ne 0 ] ; then
            # Error
            $1
            return 1
        else
            # Success
            if [ $# -gt 1 ] ; then
                $2
            fi
            return 0
        fi
    }

    # Check if is empty.
    # 1: {*} Variable to check if emtpy.
    # Out: {Boolean} 1 if variable is emtpy.
    # Return: The same as "Out".
    function is_empty() {
        if [ -z "$1" ] ; then
            # Empty
            echo 1
        else
            # No empty
            echo 0
        fi
    }

### STRING ###

    # Escape string for Bash.
    # 1: {String} String to escape for Bash.
    # Out: {String} Escaped string.
    function str_escape() {
	    printf '%q' "$1"
    }

    # Repeat string.
    # 1: {Integer} Number of repetitions.
    # 2: {String} String to repeat.
    # Out: {String} Repeated string.
    function str_repeat() {
	    let fillsize=$1
	    fill=$2
	    while [ "$fillsize" -gt "0" ] ; do
		    fill="${fill}$2"
		    let fillsize=${fillsize}-1
	    done
	    echo $fill
    }

    # Replace string.
    # 1: {String} String where replace.
    # 2: {String} Search string (REG EXP).
    # 3: {String} Replace.
    # 4: {Boolean} (Default: 1) 1 to ignore case.
    # Out: {String} Result string.
    function str_replace() {
        options="g"
        if [ $# -lt 4 ] || [ "$4" -ne "0" ] ; then
            options="${options}i"
        fi
        echo "$1" | sed "s/$2/$3/$options"
    }
    
    # Trim text.
    # 1: {String} String where trim.
    # 2: {String} (Default: " ") String to trim.
    # Out: {String} Trimed text.
    function trim() {
        chr=" "
        if [ $# -gt 1 ] ; then
            chr=$2
        fi
        echo "$1" | tr -d "$chr"
    }
    
    # String length.
    # 1: {String} Text.
    # Out: {Integer} String length.
    function str_len() {
        echo `expr "$1" : '.*'`
    }
    
    # Sub string.
    # 1: {String} String to cut.
    # 2: {Integer} Start.
    # 3: {Integer} (Optional) Count.
    # Out: {String} Result string
    function sub_str() {
        if [ $# -eq 2 ] ; then
            echo ${1:$2}
        else
            echo ${1:$2:$3}
        fi
    }

### UI ###

    # Pause.
    # 1: {String} Message.
    function pause() {
        if [ $# -le 1 ] ; then
            m="Pause..."
        else
            m=$1
        fi
        echo
        read -n 1 -p $m
        echo
    }
    
    # Print a line with full width.
    # 1: {Char} Character for line.
    # 2: {String} (Optional) Text to print at start.
    # Out: {String} Line.
    function print_line() {
        if [ $# -eq 0 ] ; then
            # No params
            len=0
            fill=""
            c="-"
        else
            # Character
            c=$(sub_str $1 0 1)
            if [ $# -eq 2 ] ; then
                # Text
                let len=$(str_len $2)+1
                fill="$2 "
            fi
        fi
        let fillsize=${SCR_WIDTH}-${len}
        while [ $fillsize -gt 0 ] ; do
            fill="${fill}${c}"
            let fillsize=${fillsize}-1
        done
        echo ${fill}
    }

### DATE / TIME ###

    # Current time.
    # Out: {String} Time.
    function now_time() {
        date '%H:%M:%S'
    }

    # Current date.
    # Out: {String} Date.
    function now_date() {
        date '+%Y-%m-%d'
    }

    # Current date and time.
    # Out: {String} Date and time.
    function now_date_time() {
        date '+%Y-%m-%d %H:%M:%S'
    }

### TAR ###

    # Compress file as .tar.gz.
    # 1: {String} Input file.
    # 2: {String} Output file (.tar.gz).
    # Out: {String} Log output.
    function tar_compress() {
        tar zcvf $(str_escape "$2") $(str_escape "$1")
        return $?
    }

    # Extract .tar.gz file.
    # 1: {String} Input file (.tar.gz).
    # 2: {String} Output path.
    # Out: {String} Log output.
    function tar_extract() {
        zxvf $(str_escape "$1") -C $(str_escape "$2")
        return $?
    }

### FILE / PATH ###

    # Check if file exists.
    # 1: {String} File path.
    # Out: {Boolean} 1 if file exists, 0 if not exists.
    # Return: The same as "Out".
    function file_exists() {
        if [ -f $(str_escape "$1") ]; then
            # Exists
            echo 1
            return 1
        else
            # Not exists
            echo 0
            return 0
        fi
    }

    # Current directory.
    # Out: {String} Current directory.
    function current_directory() {
        printf '%q' "$(pwd)"
    }

    # Current directory name.
    # Out: {String} Current directory name.
    function current_directory_name() {
        dirname "$(printf '%q' "$(readlink -f "$(printf '%q' "$0")")")"
    }
    
    # Current script file name.
    # Out: {String} Current script file name.
    function script_file_name() {
        basename "$(printf '%q' "$0")"
    }

    # Check if directory exists.
    # 1: {String} Directory path.
    # Out: {Boolean} 1 if directory exists, 0 if not exists.
    # Return: The same as "Out".
    function path_exists() {
        # if [ $(x_path_exists "/path/foo") = 1 ] ; then
        if [ -d $(str_escape "$1") ]; then
            # Exists
            echo 1
            return 1
        else
            # Not exists
            echo 0
            return 0
        fi
    }

    # Check if file contains text.
    # 1: {String} Text to search.
    # 2: {String} File where check.
    # Out: {Boolean} 1 if file contains the text, 0 if not contains the text.
    # Return: The same as "Out".
    function file_contains() {
        grep -rils $(str_escape "$1") $(str_escape "$2") > /dev/null
        if [ $? -eq 1 ]; then
            # Not contains
            echo 0
            return 0
        else
            # Contains
            echo 1
            return 1
        fi
    }

##############################################################################

# End
