# A Command allows the execution of a specific command
# Command implementations should inherit from abstract BaseCommand
# Implements the command pattern
# A command is a business process with a defined input, defined output, is reusable and easy to test
#
# @author [buntekuh]
#
class BaseCommand
  #
  # Execute perfoms the command
  # this is a helper method that instantiates the command object
  # and calls execute on the command implementation
  # @param *args The arguments to be passed to the command implementations inititalize method
  #
  # @return whatever the command implementation execute method returns
  def self.execute(*args)
    new(*args).execute
  end

  #
  # Command implementations should implement their own execute method
  #
  # @fails always
  def execute
    fail 'Please implement execute method'
  end
end
