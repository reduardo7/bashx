# Left @trim text.
#
# 1: {String} String where @trim.
# 2: {String} (Default: \s) String to @trim.
# Out: {String} Trimed text.

local src_str="$1"
local trm_base="$2"

[ -z "${trm_base}" ] && trm_base='\s'

perl -C -Mutf8 -pe "s/^(${trm_base})*//" <<< "${src_str}"
