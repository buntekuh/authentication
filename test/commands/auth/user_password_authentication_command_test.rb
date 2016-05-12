require 'test_helper'

module Auth
  class TestUserPasswordAuthenticationForm < BaseForm
    attribute :email, String
    attribute :password, String
  end

  class UserPasswordAuthenticationCommandTest < ActiveSupport::TestCase
    setup do
      user_form = Users::CreateForm.new(first_name: 'James', last_name: 'Kirk', email: 'jkirk@starfleet.ufp', password: 'Enterprise')
      @user = Users::CreateCommand.execute user_form
      @form = UserPasswordAuthenticationForm.new(email: user_form.email, password: user_form.password)
    end

    test 'succeeds' do
      assert_equal @user, UserPasswordAuthenticationCommand.execute(@form)
    end

    test 'validate_form' do
      assert_raises(UserPasswordAuthenticationCommand::InvalidForm) do
        UserPasswordAuthenticationCommand.execute TestUserPasswordAuthenticationForm.new(email: @form.email, password: @form.password)
      end

      [:email, :password].each do |attr|
        form = @form.clone
        form.send("#{attr.to_s}=", [nil, ''].sample)
        assert_raises(UserPasswordAuthenticationCommand::InvalidForm) do
          UserPasswordAuthenticationCommand.execute form
        end
      end
    end

    test 'find_user' do
      form = @form.clone
      form['email'] = 'mscott@starfleet.ufp'
      assert_raises UserPasswordAuthenticationCommand::InvalidCredentials do
        UserPasswordAuthenticationCommand.execute form
      end
    end

    test 'valid_password' do
      form = @form.clone
      form['password'] = 'BeamMeUp'
      assert_raises UserPasswordAuthenticationCommand::InvalidCredentials do
        UserPasswordAuthenticationCommand.execute form
      end
    end
  end
end
