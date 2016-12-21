# Show red alert message.
#
# *: {String} Message.

@print 3>&2
@print "$(@style color:red) $@" 3>&2
@print 3>&2
