## options*
## Read options.
##
## Params:
##   options*: {Map} Valid options specifications.
##
##
## Options Format: [KEY:VARIABLE:INPUT]*
##   where:
##     KEY:      {Char} Option key.
##     VARIABLE: {String} Valid variable name (without spaces).
##               This produces a variable like "OPTARG_XXX".
##     INPUT:    {Boolean} Option with input?
##               Optional. Default: false.
##
## Options Example: n:new p:path:true x:foo:false
##   This produces next variables:
##     - OPTARG_NEW with TRUE when "-n" is present or FALSE when "-n" is not present.
##     - OPTARG_PATH with user inputs values as Array, or EMPTY on empty user input.
##
## Usage example:
##   eval "$(@options n:new p:path:true)"
##   @print "'n' parameter: ${OPTARG_NEW}"
##   @print "'p' parameter: ${OPTARG_PATH[@]}"

local options="$@"
local variable
local config
local config_keys
local config_key
local config_var
local config_var_val_def
local config_var_val
local config_input
local config_var_prefix='OPTARG_'
local script_vars=''
local script_opts=''
local script_case=''
local OIFS="$IFS"
local variables

IFS=' ' variables=(${options}) IFS="$OIFS"

for variable in ${variables[@]} ; do
  IFS=':' config=(${variable}) IFS="$OIFS"
  config_keys="${config[0]}"
  IFS='' config_keys=(${config_keys}) IFS="$OIFS"

  for config_key in ${config_keys[@]} ; do
    config_var="${config[1]}"
    config_input=${config[2]:-false}

    [[ ${#config_key} -eq 1 ]] || @throw-invalid-param options 'Invalid KEY value'
    [ ! -z "${config_var}" ] || @throw-invalid-param options 'Invalid VARIABLE value'
    @is-boolean "${config_input}" || @throw-invalid-param options 'Invalid INPUT value'

    config_var="${config_var_prefix}$(@str-to-upper "${config_var}")"

    if [ -z "${script_opts}" ]; then
      script_opts="${config_key}"
    else
      script_opts="${script_opts}${config_key}"
    fi

    if ${config_input}; then
      config_var_val_def='=()'
      config_var_val='+=($OPTARG)'
    else
      config_var_val_def='=false'
      config_var_val='=true'
      script_opts="${script_opts}i:"
    fi

    [ -z "${script_vars}" ] || script_vars="${script_vars}${BASHX_NL}"
    [ -z "${script_case}" ] || script_case="${script_case}${BASHX_NL}${BASHX_TAB}${BASHX_TAB}"
    script_vars="${script_vars}${config_var}${config_var_val_def}"
    script_opts="${script_opts}:"
    script_case="${script_case}${config_key}) ${config_var}${config_var_val} ;;"
  done
done

cat <<EOF
${script_vars}
while getopts ${script_opts} opt
do
  case "\$opt" in
    ${script_case}
    \?) @error "ERROR: Invalid option -\$OPTARG" ;;
    :) @error "Missing option argument for -\$OPTARG" ;;
    *) @error "Unimplemented option: -\$OPTARG" ;;
  esac
done
shift \$((OPTIND - 1))
EOF

# OPTARG_NET=false
# OPTARG_PORTS='' #@TODO
# while getopts ni::p: opt
# do
#   case "$opt" in
#     n) OPTARG_NET=true ;;
#     p) #@TODO
#       [ ! -z "$OPTARG_PORTS" ] && OPTARG_PORTS="$OPTARG_PORTS,"
#       OPTARG_PORTS="$OPTARG_PORTS$OPTARG"
#       ;;
#     \?) @error "ERROR: Invalid option -$OPTARG" ;;
#     :) @error "Missing option argument for -$OPTARG" ;;
#     *) @error "Unimplemented option: -$OPTARG" ;;
#   esac
# done
# shift $((OPTIND - 1))
