require 'test_helper'

module Auth
  class UserPasswordAuthenticationFormTest < ActiveSupport::TestCase
    setup do
      @authetication_form = UserPasswordAuthenticationForm.new email: 'foo@bar.de', password: 'chooChoo'
    end

    test 'responds to attributes' do
      assert_equal @authetication_form.email, 'foo@bar.de'
      assert_equal @authetication_form.password, 'chooChoo'
    end

    test 'validates attributes' do
      assert @authetication_form.valid?

      @authetication_form.email = [nil, ''].sample
      @authetication_form.password = [nil, ''].sample
      
      assert_not @authetication_form.valid?
      assert_equal 2, @authetication_form.errors.size
      assert_equal ['must_be_present'], @authetication_form.errors[:email]
      assert_equal ['must_be_present'], @authetication_form.errors[:password]
    end

    test 'persisted?' do
      assert_not @authetication_form.persisted?
    end
  end
end