require 'test_helper'

module Auth
  class UserSignInFormTest < ActiveSupport::TestCase
    setup do
      @sign_in_form = Auth::UserSignInForm.new email: 'foo@bar.de', password: 'chooChoo'
    end

    test 'responds to attributes' do
      assert_equal @sign_in_form.email, 'foo@bar.de'
      assert_equal @sign_in_form.password, 'chooChoo'
    end

    test 'validates attributes' do
      assert @sign_in_form.valid?

      @sign_in_form.email = [nil, ''].sample
      @sign_in_form.password = [nil, ''].sample
      
      assert_not @sign_in_form.valid?
      assert_equal 2, @sign_in_form.errors.size
      assert_equal ['must_be_present'], @sign_in_form.errors[:email]
      assert_equal ['must_be_present'], @sign_in_form.errors[:password]
    end
  end
end