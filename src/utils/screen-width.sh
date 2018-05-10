##
## Screen width.
##
## Out: {Integer} Screen width.

if type tput >/dev/null 2>/dev/null; then
  tput cols
else
  echo ${APP_WIDTH}
fi
