if [ -d "${path}" ]; then
  if [ -f "${script}" ]; then
    rm -f "${script}" || @error "Can not remove file '$(@style bold color:blue)${script}$(@style default)'"
    @print "File '$(@style bold color:blue)${script}$(@style default)' $(@style bold color:red)deleted$(@style default)!"
  fi

  # Empty directory?
  if [ -z "$(ls -A "${path}")" ]; then
    rm -rf "${path}" || @error "Can not remove directory '$(@style bold color:blue)${path}$(@style default)'"
    @print "Directory '$(@style bold color:blue)${path}$(@style default)' now is empty, $(@style bold color:red)deleted$(@style default)!"
  fi
fi

@end
