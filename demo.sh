#!/bin/bash
. ./xbash.sh

APP_TITLE="Demo XBash"
APP_VERSION="1"
COLOR_DEFAULT="cyan"

function __info() { #%nSee system info.
    # Info
    e "$(ecolor green)Script name: $(script_file_name)"
    e "$(ecolor red)Path: $(current_directory)"
    e "Date and time: $(now_date_time)"

    # Pause script
    pause

    # Check root
    if [ $(is_root) = $TRUE ] ; then
        e "$(ecolor red)ROOT$(ecolor green) user"
    else
        e "$(ecolor green)No $(ecolor red)ROOT$(ecolor green) user"
    fi
}

function __params() { # param1 %nparam1: Text to print.
    e "Text passed: $(ecolor red) '$1'"
}

function __to() { # time command%n%ttime: Time in seconds.%n%tcommand: Command to execute.
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

function exit_callback() {
    e "Function called on exit!"
}

set_on_exit exit_callback

# Run
run "$@"
