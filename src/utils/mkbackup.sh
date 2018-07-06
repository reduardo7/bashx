## src [dest [filename]]
## Create file or directory backup.
##
## Params;
##   src:      {String} File or directory to backup.
##   dest:     {String} Destination directory.
##             Optional. Default: {src} directory.
##   compress: {Boolean} Compress as .tar.gz?
##             Optional. Default: false.
##   filename: {String} Backup filename.
##             Optional. Default: Add suffix `.bkp.{date-time}` to {src} name.
##
## Out: Full backup file path.

local src="$1"
local dest="$2"
local compress=${3:-false}
local filename="${4}"
