#!/bin/bash
. "$(dirname "$0")/src/xbash.sh"

# ################################################
#
# Demo Script.
#
# This file contains an implementation as example.
#
# ################################################

# On exit callback
set_on_exit exit_callback

#styles\nTest style.
function __style() {
    e "Style ($@): $(style $@)[ # STYLE # ]"
}

#\nUser Interface.
function __ui() {
    # Info
    e "$(style color:green)Script name: $(script_file_name)"
    e "$(style color:red)Path: $(current_directory)"
    e "Date and time: $(now_date_time)"

    # User Input
    user_input "Enter some text" "[NO INPUT | DEFAULT VALUE]"
    e "Exit code: $?. User input: $(style bold)${RESULT}"

    # Pause script
    pause

    # Confirm
    options=(a A)
    if user_confirm "Confirm? [A/B]" $options $FALSE ; then
        e "User confirm operation!"
    else
        e "User not confirm operation!"
    fi

    # Check root
    if is_root ; then
        e "$(style color:red)ROOT$(style color:green) user"
    else
        e "$(style color:green)No $(style color:red)ROOT$(style color:green) user"
    fi
}

# param1\nparam1: Text to print.
__params(){
    e "Action called: $(style color:red) '$ACTION'"
    e "Text passed: $(style color:red) '$@'"
}

# time command\ntime: Time in seconds.\ncommand: Command to execute.
function __to() {
    timeout "$1" "$2"
    r=$?
    e "Exit code: $r"
}

function __testError() {
    e "Generating an error..."
    e $error_var_x
    error_not_exists_test
    check_error "ec red Exit for error!"
    e "NO EXECUTE"
}

function __split() {
    str="bla@some.com bbb;john@home.com jjj"
    sep=";"
    str_explode "$sep" "$str"
    array_count=$?
    e "String to explode: '$str'"
    e "Separator: '$sep'"
    e "Array length: $array_count"
    e "Array values:"
    for i in ${RESULT[@]} ; do
        e "\t'$i'"
    done
}

function __exists() {
    if wait_for_file_exists "/tmp/test.txt" 10 ; then
        e "File exists!"
    else
        e "File not exists!"
    fi
}

function exit_callback() {
    if [ "$ACTION" != 'usage' ]; then
        e "Function called on exit!"
    fi
}

# Run
run "$@"
