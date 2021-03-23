testFunc() {
  echo foo
}

@@assert.noOut "@function.exists xx"
@@assert.noOut "@function.exists echo"
@@assert.noOut "@function.exists testFunc"
@@assert.exec '@function.exists' false 'xx'
@@assert.exec '@function.exists' false 'echo'
@@assert.exec '@function.exists' true 'testFunc'
