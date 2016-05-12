require 'test_helper'

module Auth
  class UserPasswordAuthenticationFormTest < ActiveSupport::TestCase
    setup do
      @autehtication_form = UserPasswordAuthenticationForm.new email: 'foo@bar.de', password: 'chooChoo'
    end

    test 'responds to attributes' do
      assert_equal @autehtication_form.email, 'foo@bar.de'
      assert_equal @autehtication_form.password, 'chooChoo'
    end

    test 'validates attributes' do
      assert @autehtication_form.valid?

      @autehtication_form.email = [nil, ''].sample
      @autehtication_form.password = [nil, ''].sample
      
      assert_not @autehtication_form.valid?
      assert_equal 2, @autehtication_form.errors.size
      assert_equal ['must_be_present'], @autehtication_form.errors[:email]
      assert_equal ['must_be_present'], @autehtication_form.errors[:password]
    end
  end
end