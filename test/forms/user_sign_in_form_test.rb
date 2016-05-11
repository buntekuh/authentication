require 'test_helper'


class UserSignInFormTest < ActiveSupport::TestCase
  setup do
    @sign_in_form = Auth::UserSignInForm.new email: 'foo@bar.de', password: 'choo'
  end

  test 'responds to attributes' do
    assert_equal @sign_in_form.email, 'foo@bar.de'
    assert_equal @sign_in_form.password, 'choo'
  end

  test 'validates attributes' do
    assert @sign_in_form.valid?

    @sign_in_form.email = [nil, ''].sample
    @sign_in_form.password = [nil, ''].sample
    
    assert_not @sign_in_form.valid?
    assert_equal 2, @sign_in_form.errors.size
    assert_equal ["can't be blank"], @sign_in_form.errors[:email]
    assert_equal ["can't be blank"], @sign_in_form.errors[:password]
  end
end