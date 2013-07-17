#!/bin/bash
. ./src/xbash.sh

# ####################
#
# Application Manager.
#
# ####################

# Load actions
if [ -d "${ACTIONS_PATH}" ]; then
    for f in ${ACTIONS_PATH}/* ; do
        if [ -f "${f}" ]; then
            # Create action function
            _fn="__$(file_name "${f}" $TRUE)"
            eval "${_fn}() { . ${f}; }"

        fi
    done
fi
unset _fn

# Run
run "$@"