require 'test_helper'

module Users
  class TestCreateForm < BaseForm
    attribute :first_name,            String
    attribute :last_name,             String
    attribute :email,                 String
    attribute :password,              String
  end

  class CreateCommandTest < ActiveSupport::TestCase
    setup do
      @form = CreateForm.new(first_name: 'der Alte', last_name: 'Fritz', email: 'king@preussen.pn', password: 'Charlotte')
    end

    test 'fail_if_email_already_exists' do
      CreateCommand.execute @form
      assert_raises(CreateCommand::EmailPresent) do
        CreateCommand.execute @form
      end
    end

    test 'validate_form' do
      assert_raises(CreateCommand::InvalidForm) do
        CreateCommand.execute TestCreateForm.new
      end

      [:first_name, :last_name, :email, :password].each do |attr|
        form = @form.clone
        form.send("#{attr.to_s}=", [nil, ''].sample)
        assert_raises(CreateCommand::InvalidForm) do
          CreateCommand.execute form
        end
      end
    end

    test 'seed_and_encrypt_password' do
      user = CreateCommand.execute @form
      assert user.seed.present?
      assert user.password_digest.present?
      assert_equal EncryptionService.encrypt_with_seed(user.seed, @form.password), user.password_digest
    end

    test 'generate_session_token' do
      user = CreateCommand.execute @form
      assert user.session_token.present?
      assert_equal 64, user.session_token.length
    end

    test 'save_user' do
      assert_difference('::User.count', 1) do
        user = CreateCommand.execute @form
        assert_equal user, User.last
      end
    end
  end
end
