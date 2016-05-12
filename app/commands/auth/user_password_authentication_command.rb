module Auth
  #
  # Validates the sign-in form and finds the user to sign in
  # @author buntekuh
  class UserPasswordAuthenticationCommand < BaseCommand
    class InvalidForm       < StandardError; end
    class InvalidCredentials < StandardError; end

    private_attr_accessor :form, :user

    # @param form [UserPasswordAuthenticationForm]
    def initialize(form)
      self.form = form
    end

    #
    # [signs in user]
    #
    # @return [User] [the validated user]
    # @raise [InvalidForm] [unless the form is valid]
    # @raise [ InvalidCredentials] [if the user could not be found in the db or password is not correct]
    #
    def execute
      validate_form
      find_user
      valid_password?
      user
    end

    private
    #
    # [validates UserPasswordAuthenticationForm]
    #
    # @return [true, false]
    def validate_form
      fail InvalidForm unless form.is_a? UserPasswordAuthenticationForm
      fail InvalidForm unless form.valid?
    end

    #
    # [finds the user in the db or raises error]
    #
    # @return [User]
    def find_user
      self.user = User.find_by(email: form.email)

      if user.nil?
        form.errors.add(:email, 'not_found')
        fail InvalidCredentials
      end
        
    end

    #
    # [validates the form password against the user password or raises error]
    #
    # @return [true, false]
    def valid_password?
      unless EncryptionService.encrypt_with_seed(user.seed, form.password) == user.password_digest
        form.errors.add(:password, 'invalid')
        fail InvalidCredentials
      end
    end
  end
end
