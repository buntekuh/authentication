require 'test_helper'

class TestCommand < BaseCommand
  private_attr_accessor :arg

  def initialize arg
    self.arg = arg
  end

  def execute
    arg.to_s
  end
end

class BaseCommandTest < ActiveSupport::TestCase
  test 'execute' do
    assert_raises(RuntimeError) do
      BaseCommand.execute
    end

    assert_equal '1', TestCommand.execute(1)
  end
end
