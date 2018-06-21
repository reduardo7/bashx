## (options*)
## Read options.
##
## Params:
##   (options*): {Map} Valid options specifications.
##
##
## Options Format: ( KEY:VARIABLE:REQUIRED:INPUT ... )
##   where:
##     KEY:      {Char} Option key.
##     VARIABLE: {String} Valid variable name (without spaces).
##               This produces a variable like "OPTARG_XXX".
##     REQUIRED: {Boolean} Is the option required? Fail when not defined.
##               Optional. Default: true.
##     INPUT:    {Boolean} Option with input?
##               Optional. Default: false.
##
## Options Example: ( n:new p:path:false:true x:foo:false )
##   This produces next variables:
##     - OPTARG_NEW with TRUE when "-n" is present or FALSE when "-n" is not present.
##     - OPTARG_PATH with user input value, or EMPTY if no
##
## Usage example: eval $(@options ( n:new p:path:false ))

local options="$@"
local OIFS="$IFS"
local variable
local config
local config_key
local config_var
local config_required
local config_input
local config_var_prefix='OPTARG_'

IFS=' ' options=(${options}) IFS="$OIFS"

for variable in ${variables[@]} ; do
  IFS=':' config=(${variable}) IFS="$OIFS"
  config_key="${config[0]}"
  config_var="${config[1]}"
  config_required=${config[2]:-true}
  config_input=${config[3]:-false}

  [ ! -z "${config_var}" ] || @throw-invalid-param options
  config_var="${config_var_prefix}$(@str-to-upper "${config_var}")"
done



OPTARG_NET=false
OPTARG_PORTS='' #@TODO
while getopts ni::p: opt
do
  case "$opt" in
    n) OPTARG_NET=true ;;
    p) #@TODO
      [ ! -z "$OPTARG_PORTS" ] && OPTARG_PORTS="$OPTARG_PORTS,"
      OPTARG_PORTS="$OPTARG_PORTS$OPTARG"
      ;;
    \?) @error "ERROR: Invalid option -$OPTARG" ;;
    :) @error "Missing option argument for -$OPTARG" ;;
    *) @error "Unimplemented option: -$OPTARG" ;;
  esac
done
shift $((OPTIND - 1))
