require 'test_helper'

module Users
  class CreateFormTest < ActiveSupport::TestCase
    setup do
      @form = CreateForm.new first_name: 'Bernd', last_name: 'Eickhoff', email: 'foo@bar.de', password: 'chooChoo'
    end

    test 'responds to attributes' do
      assert_equal @form.first_name, 'Bernd'
      assert_equal @form.last_name, 'Eickhoff'
      assert_equal @form.email, 'foo@bar.de'
      assert_equal @form.password, 'chooChoo'
    end

    test 'validates attributes' do
      assert @form.valid?

      @form.first_name = [nil, ''].sample
      @form.last_name = [nil, ''].sample
      @form.email = [nil, ''].sample
      @form.password = [nil, ''].sample
      
      assert_not @form.valid?
      assert_equal 5, @form.errors.size
      assert_equal ['must_be_present'], @form.errors[:first_name]
      assert_equal ['must_be_present'], @form.errors[:last_name]
      assert_equal ['must_be_present'], @form.errors[:email]
      password_errors = @form.errors[:password]
      assert password_errors.include? 'must_be_present'
      assert password_errors.include? 'too_short'
    end
  end
end