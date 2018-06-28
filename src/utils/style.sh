## *
## Change screen print style.
##
## Params:
##   *: Style strings.
##     The style separator can be:
##         - : (two points)
##         - = (equal)
##     Simple:
##         - bold: Bold text.
##         - underline: Underline.
##         - reverse | negative: Invert color.
##         - hidden | hide: Hide text.
##         - show | visible: Show hidden text.
##         - dim: Gray style.
##         - blink: Flashing text.
##         - normal: Text without bold format.
##         - reset: Reset all styles to system default.
##         - default: Reset all styles to APP style.
##     Colors: Use "color[:=]*", where "*" can be:
##         - black
##         - blue
##         - blue-light
##         - cyan
##         - cyan-light
##         - gray
##         - gray-light
##         - green
##         - green-light
##         - magenta | purple
##         - magenta-light
##         - red
##         - red-light
##         - yellow | coffe
##         - yellow-light
##         - white
##         - default | normal | auto: Default APP color.
##         - [A Number between 0 and 255]: Print custom color.
##     Background: Use "background[:=]*" or "bg[:=]*", where "*" can be:
##         - black
##         - blue
##         - blue-light
##         - cyan
##         - cyan-light
##         - gray
##         - gray-light
##         - green
##         - green-light
##         - magenta | purple
##         - magenta-light
##         - red
##         - red-light
##         - yellow | coffe
##         - yellow-light
##         - white
##         - system | normal | auto: Default system background color.
##         - [A Number between 0 and 255]: Print custom color.
##     Styles: Use as "style[:=]status":
##         - underline: Underline.
##             - on | true | 1: Enable underline.
##             - off | false | 0: Disable underline.
##         - bold: Bold.
##             - on | true | 1: Enable bold.
##             - off | false | 0: Disable bold.
##         - dim: Gray style.
##             - on | true | 1: Enable dim.
##             - off | false | 0: Disable dim.
##         - blink: Flashing text.
##             - on | true | 1: Enable blink.
##             - off | false | 0: Disable blink.
##         - reverse | negative: Invert color.
##             - on | true | 1: Enable negative.
##             - off | false | 0: Disable negative.
##         - display: Show or hide text.
##             - visible | show | true | 1: Show text.
##             - hidden | none | hide | false | 0: Hide text.
##
## Out: {String} Style console string.
##
## Global Variables:
##   BASHX_COLORS_DISABLED: {Integer} Set vale to '1' to diable this function
##                          and disable output colors.
##
## Examples:
##   @print "normal color $(@style color:red)text in red $(@style color:black background:yellow)black color$(@style default) normal color"
##   # Restore default APP colors
##   @style default
##   # Set gray color as background color for next output
##   @style background gray
##   @print "$(@style color:red bold underline:on)Title$(@style underline:off):$(@style normal dim) Description..."

if ${BX_APP_COLORS_ENABLED} && [ "${BASHX_COLORS_DISABLED}" != '1' ]; then
  local OIFS="$IFS"

  # No parameters
  local prms="$@"
  if [[ $# -eq 0 ]]; then
    # Default color
    prms='default'
  fi

  # Styles
  local c=''
  IFS=' ' prms=(${prms}) IFS="$OIFS"

  for p in ${prms[@]} ; do
    # Style code
    local y=''
    # Split
    IFS='[=:]' p=(${p}) IFS="$OIFS"
    # Parts
    local s="${p[0]}"
    local v="${p[1]}"

    # Default
    if [ -z "$v" ] && [ "$p" == 'default' ]; then
      # Reset style
      if [ -z "$c" ]; then
        c='0'
      else
        c="$c;0"
      fi
      # Default color
      s='color'
      v="${BX_APP_COLOR_DEFAULT}"
    fi

    if [ ! -z "$v" ]; then
      if [ "$s" == 'color' ] && ( [ "$v" == 'default' ] || [ "$v" == 'normal' ] || [ "$v" == 'auto' ] ); then
        if [ -z "${BX_APP_COLOR_DEFAULT}" ] || [ "${BX_APP_COLOR_DEFAULT}" == 'default' ] || [ "${BX_APP_COLOR_DEFAULT}" == 'normal' ] || [ "${BX_APP_COLOR_DEFAULT}" == 'auto' ]; then
          # Invalid default or default not defined
          y='0'
          # Invalidate case
          v=''
          s=''
        else
          # Default color
          v="${BX_APP_COLOR_DEFAULT}"
        fi
      fi
      case "$s" in
        'color')
          case "$v" in
            'black')              y='30' ;;
            'blue')               y='34' ;;
            'blue-light')         y='94' ;;
            'cyan')               y='36' ;;
            'cyan-light')         y='96' ;;
            'gray')               y='90' ;;
            'gray-light')         y='37' ;;
            'green')              y='32' ;;
            'green-light')        y='92' ;;
            'magenta' | 'purple') y='35' ;;
            'magenta-light')      y='95' ;;
            'red')                y='31' ;;
            'red-light')          y='91' ;;
            'yellow' | 'coffe')   y='33' ;;
            'yellow-light')       y='93' ;;
            'white')              y='97' ;;
            # Color (0 - 255)
            [0-9])                y="38;5;${v}" ;;
          esac
          ;;
        'background' | 'bg')
          case "$v" in
            'black')                      y='40' ;;
            'blue')                       y='44' ;;
            'blue-light')                 y='104' ;;
            'cyan')                       y='46' ;;
            'cyan-light')                 y='106' ;;
            'gray')                       y='100' ;;
            'gray-light')                 y='47' ;;
            'green')                      y='42' ;;
            'green-light')                y='102' ;;
            'magenta' | 'purple')         y='45' ;;
            'magenta-light')              y='105' ;;
            'red')                        y='41' ;;
            'red-light')                  y='101' ;;
            'yellow' | 'coffe')           y='43' ;;
            'yellow-light')               y='103' ;;
            'white')                      y='107' ;;
            "system" | 'normal' | 'auto') y='49' ;;
            # Color (0-255)
            [0-9])                        y="48;5;${v}" ;;
          esac
          ;;
        'underline')
          case "$v" in
            'on' | 'true' | '1')   y='4' ;;
            'off' | 'false' | '0') y='24' ;;
          esac
          ;;
        'bold')
          case "$v" in
            'on' | 'true' | '1')   y='1' ;;
            'off' | 'false' | '0') y='21' ;;
          esac
          ;;
        'dim')
          # Gray stile
          case "$v" in
            'on' | 'true' | '1')   y='2' ;;
            'off' | 'false' | '0') y='22' ;;
          esac
          ;;
        'blink')
          # Flashing text
          case "$v" in
            'on' | 'true' | '1')   y='5' ;;
            'off' | 'false' | '0') y='25' ;;
          esac
          ;;
        'reverse' | 'negative')
          case "$v" in
            'on' | 'true' | '1')   y='7' ;;
            'off' | 'false' | '0') y='27' ;;
          esac
          ;;
        'display')
          case "$v" in
            'visible' | 'show' | 'true' | '1')          y='28' ;;
            'hidden' | 'none' | 'hide' | 'false' | '0') y='8' ;;
          esac
          ;;
      esac
    else
      case "$p" in
        'bold')                 y='1' ;;
        'underline')            y='4' ;;
        'reverse' | 'negative') y='7' ;;
        'hidden' | 'hide')      y='8' ;;
        'show' | 'visible')     y='28' ;;
        # Gray stile
        'dim')                  y='2' ;;
        # Flashing text
        'blink')                y='5' ;;
        # No bold
        'normal')               y='21' ;;
        # Reset all styles
        'reset')                y='0' ;;
      esac
    fi

    if [ ! -z "$y" ]; then
      # Append style
      if [ -z "$c" ]; then
        c="$y"
      else
        c="$c;$y"
      fi
    fi
  done

  if [ ! -z "${c}" ]; then
    echo -en "${BASHX_KEY_ESC}[${c}m"
  fi
fi
