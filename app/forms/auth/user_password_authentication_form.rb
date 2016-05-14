module Auth
  #
  # The user sign in form
  #
  # @author [buntekuh]
  #
  class UserPasswordAuthenticationForm < BaseForm
    # Attributes
    attribute :email, String
    attribute :password, String

    # Validations
    validates :email, presence: { message: 'must_be_present' }
    validates :password, presence: { message: 'must_be_present' }

    # 
    # Called from FormHelper form_for method
    # 
    # @return false
    def persisted?
      false
    end
  end
end
