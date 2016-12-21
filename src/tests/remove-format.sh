@@assertNoErrOut '@remove-format "asd"'

@@assertEqual "$(echo -e "\t foo\nbar \t")" "$(@remove-format "$(echo -e "\t foo\nbar \t")")"
@@assertEqual " yellow red " "$(@remove-format " $(@style color:yellow)yellow $(@style color:red)red ")"
