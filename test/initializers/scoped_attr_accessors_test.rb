class TestScopedAttrs
  protected_attr_accessor :protected_attribute
  private_attr_accessor :private_attribute
  
  def initialize
    self.protected_attribute = 'protected'
    self.private_attribute = 'private'
  end

  def get_protected
    protected_attribute
  end

  def get_private
    private_attribute
  end

  def get_protected_self
    self.protected_attribute
  end

  # This method should fail, because a private attribute cannot be called explicitely
  def get_private_self
    self.private_attribute
  end
end

class ScopedAttrAccessorsTest < ActiveSupport::TestCase
  test 'protected_attr_accessor' do
    test_class = TestScopedAttrs.new
    other_test_class = TestScopedAttrs.new

    assert_raises(NoMethodError) do
      test_class.protected_attribute
    end
    
    assert_equal 'protected', test_class.get_protected
    assert_equal 'protected', test_class.get_protected_self
  end

  test 'private_attr_accessor' do
    test_class = TestScopedAttrs.new
    other_test_class = TestScopedAttrs.new

    assert_raises(NoMethodError) do
      test_class.private_attribute
    end
    
    assert_equal 'private', test_class.get_private

    assert_raises(NoMethodError) do
      assert_equal 'private', test_class.get_private_self
    end
  end


end