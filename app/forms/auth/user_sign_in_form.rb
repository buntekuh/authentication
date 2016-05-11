module Auth
  #
  # The user sign in form
  #
  # @author [buntekuh]
  #
  class UserSignInForm < BaseForm
    # Attributes
    attribute :email, String
    attribute :password, String

    # Validations
    validates :email, presence: true
    validates :password, presence: true
  end
end
