## src [dest [filename]]
## Create backup of file.
##
## Params;
##   src:      {String} File or directory to backup.
##   dest:     {String} Destination directory.
##             Optional. Default: {src} directory.
##   filename: {String} Backup filename.
##             Optional. Default: Add suffix `.bkp.{date-time}` to {src} name.
##
## Out: Full backup file path.

echo "${APP_TITLE} v${APP_VERSION}"
