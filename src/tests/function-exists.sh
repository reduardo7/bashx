testFunc() {
  echo foo
}

@@assertNoOut "@function-exists xx"
@@assertNoOut "@function-exists echo"
@@assertNoOut "@function-exists testFunc"
@@assertExec '@function-exists' false 'xx'
@@assertExec '@function-exists' false 'echo'
@@assertExec '@function-exists' true 'testFunc'
