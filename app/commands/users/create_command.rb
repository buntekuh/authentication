module Users
  #
  # Creates users with address and sends welcome email
  #
  class CreateCommand < BaseCommand
    class InvalidForm < StandardError; end
    class EmailPresent < StandardError; end

    private_attr_accessor :form, :user, :password

    # @param [User::CreateForm]
    def initialize(_form)
      self.form = _form
      self.user = User.new({ first_name: form.first_name, last_name: form.last_name, email: form.email })
    end

    # Creates a User
    # @return [User] the generated user
    # @raise [InvalidForm] if the form is not valid
    # @raise [EmailPresent] if a user with the given email already exists
    # @raise [ActiveRecord::RecordInvalid] if the database write fails for whatever reason
    def execute
      fail_if_email_already_exists
      validate_form
      seed_and_encrypt_password
      generate_session_token
      save_user

      user
    end

    private

    def fail_if_email_already_exists
      fail EmailPresent if User.where({email: form.email}).present?
    end

    def validate_form
      fail InvalidForm unless form.is_a? CreateForm
      fail InvalidForm unless form.valid?
    end

    def seed_and_encrypt_password
      user.seed, user.password_digest = EncryptionService.seed_and_encrypt(form.password)
    end

    def generate_session_token
      loop do
        user.session_token = EncryptionService.generate_session_token
        break if User.where(session_token: user.session_token).empty?
      end
    end

    def save_user
      user.save!
    end
  end
end
