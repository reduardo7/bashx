# Change screen print style.
#
# 1-*: Style strings.
#   The style separator can be:
#       - : (two points)
#       - = (equal)
#   Simple:
#       - bold: Bold text.
#       - underline: Underline.
#       - reverse | negative: Invert color.
#       - hidden | hide: Hide text.
#       - show | visible: Show hidden text.
#       - dim: Gray style.
#       - blink: Flashing text.
#       - normal: Text without bold format.
#       - reset: Reset all styles to system default.
#       - default: Reset all styles to APP style.
#   Colors: Use "color[:=]*", where "*" can be:
#       - black
#       - blue
#       - blue_light
#       - cyan
#       - cyan_light
#       - gray
#       - gray_light
#       - green
#       - green_light
#       - magenta | purple
#       - magenta_light
#       - red
#       - red_light
#       - yellow | coffe
#       - yellow_light
#       - white
#       - default | normal | auto: Default APP color.
#       - [A Number between 0 and 255]: Print custom color.
#   Background: Use "background[:=]*" or "bg[:=]*", where "*" can be:
#       - black
#       - blue
#       - blue_light
#       - cyan
#       - cyan_light
#       - gray
#       - gray_light
#       - green
#       - green_light
#       - magenta | purple
#       - magenta_light
#       - red
#       - red_light
#       - yellow | coffe
#       - yellow_light
#       - white
#       - system | normal | auto: Default system background color.
#       - [A Number between 0 and 255]: Print custom color.
#   Styles: Use as "style[:=]status":
#       - underline: Underline.
#           - on | true | 1 | $TRUE: Enable underline.
#           - off | false | 0 | $FALSE: Disable underline.
#       - bold: Bold.
#           - on | true | 1 | $TRUE: Enable bold.
#           - off | false | 0 | $FALSE: Disable bold.
#       - dim: Gray style.
#           - on | true | 1 | $TRUE: Enable dim.
#           - off | false | 0 | $FALSE: Disable dim.
#       - blink: Flashing text.
#           - on | true | 1 | $TRUE: Enable blink.
#           - off | false | 0 | $FALSE: Disable blink.
#       - reverse | negative: Invert color.
#           - on | true | 1 | $TRUE: Enable negative.
#           - off | false | 0 | $FALSE: Disable negative.
#       - display: Show or hide text.
#           - visible | show | true | 1 | $TRUE: Show text.
#           - hidden | none | hide | false | 0 | $FALSE: Hide text.
# Out: {String} Style console string.
# Examples:
#   e "normal color $(@style color:red)text in red $(@style color:black background:yellow)black color$(@style default) normal color"
#   @style default # Restore default APP colors
#   @style background gray # Set gray color as background color for next output
#   e "$(@style color:red bold underline:on)Title$(@style underline:off):$(@style normal dim) Description..."

# No parameters
local prms="$@"
  if [ $# -eq 0 ]; then
    # Default color
    prms="default"
  fi

  # Styles
  local c=""
  for q in "$prms" ; do
    # Style code
    local y=""
    # To lower
    local p="`@str_to_lower "$q"`"
    # Split
    @str_explode "[=:]" "$p"
    # Parts
    local s=`@trim "${RESULT[0]}"`
    local v=`@trim "${RESULT[1]}"`

    # Default
    if [ -z "$v" ] && [ "$p" == "default" ]; then
      # Reset style
      if [ -z "$c" ]; then
        c="0"
      else
        c="$c;0"
      fi
      # Default color
      s="color"
      v="${COLOR_DEFAULT}"
    fi

    if [ ! -z "$v" ]; then
      if [ "$s" == "color" ] && ( [ "$v" == "default" ] || [ "$v" == "normal" ] || [ "$v" == "auto" ] ); then
        if [ -z "${COLOR_DEFAULT}"] || [ "${COLOR_DEFAULT}" == 'default' ] || [ "${COLOR_DEFAULT}" == 'normal' ] || [ "${COLOR_DEFAULT}" == 'auto' ]; then
          # Invalid default or default not defined
          y="0"
          # Invalidate case
          v=""
          s=""
        else
          # Default color
          v="${COLOR_DEFAULT}"
        fi
      fi
      case "$s" in
        "color")
          case "$v" in
            "black")              y="30" ;;
            "blue")               y="34" ;;
            "blue_light")         y="94" ;;
            "cyan")               y="36" ;;
            "cyan_light")         y="96" ;;
            "gray")               y="90" ;;
            "gray_light")         y="37" ;;
            "green")              y="32" ;;
            "green_light")        y="92" ;;
            "magenta" | "purple") y="35" ;;
            "magenta_light")      y="95" ;;
            "red")                y="31" ;;
            "red_light")          y="91" ;;
            "yellow" | "coffe")   y="33" ;;
            "yellow_light")       y="93" ;;
            "white")              y="97" ;;
            # Color (0 - 255)
            [0-9])                y="38;5;${v}" ;;
          esac
          ;;
        "background" | "bg")
          case "$v" in
            "black")                      y="40" ;;
            "blue")                       y="44" ;;
            "blue_light")                 y="104" ;;
            "cyan")                       y="46" ;;
            "cyan_light")                 y="106" ;;
            "gray")                       y="100" ;;
            "gray_light")                 y="47" ;;
            "green")                      y="42" ;;
            "green_light")                y="102" ;;
            "magenta" | "purple")         y="45" ;;
            "magenta_light")              y="105" ;;
            "red")                        y="41" ;;
            "red_light")                  y="101" ;;
            "yellow" | "coffe")           y="43" ;;
            "yellow_light")               y="103" ;;
            "white")                      y="107" ;;
            "system" | "normal" | "auto") y="49" ;;
            # Color (0-255)
            [0-9])                        y="48;5;${v}" ;;
          esac
          ;;
        "underline")
          case "$v" in
            "on" | "true" | "1" | "${TRUE}")    y="4" ;;
            "off" | "false" | "0" | "${FALSE}") y="24" ;;
          esac
          ;;
        "bold")
          case "$v" in
            "on" | "true" | "1" | "${TRUE}")    y="1" ;;
            "off" | "false" | "0" | "${FALSE}") y="21" ;;
          esac
          ;;
        "dim")
          # Gray stile
          case "$v" in
            "on" | "true" | "1" | "${TRUE}")    y="2" ;;
            "off" | "false" | "0" | "${FALSE}") y="22" ;;
          esac
          ;;
        "blink")
          # Flashing text
          case "$v" in
            "on" | "true" | "1" | "${TRUE}")    y="5" ;;
            "off" | "false" | "0" | "${FALSE}") y="25" ;;
          esac
          ;;
        "reverse" | "negative")
          case "$v" in
            "on" | "true" | "1" | "${TRUE}")    y="7" ;;
            "off" | "false" | "0" | "${FALSE}") y="27" ;;
          esac
          ;;
        "display")
          case "$v" in
            "visible" | "show" | "true" | "1" | "${TRUE}")           y="28" ;;
            "hidden" | "none" | "hide" | "false" | "0" | "${FALSE}") y="8" ;;
          esac
          ;;
      esac
    else
      case "$p" in
        "bold")                 y="1" ;;
        "underline")            y="4" ;;
        "reverse" | "negative") y="7" ;;
        "hidden" | "hide")      y="8" ;;
        "show" | "visible")     y="28" ;;
        # Gray stile
        "dim")                  y="2" ;;
        # Flashing text
        "blink")                y="5" ;;
        # No bold
        "normal")               y="21" ;;
        # Reset all styles
        "reset")                y="0" ;;
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
    echo -en "\e[${c}m"
  fi
