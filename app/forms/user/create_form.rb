module User
  #
  # Form used to create users
  #
  # @author [buntekuh]
  #
  class CreateForm < BaseForm
    # Attributes
    attribute :first_name,            String
    attribute :last_name,             String
    attribute :email,                 String
    attribute :password,              String

    # Validations
    validates :email, presence: { message: 'must_be_present' }
    validates :password, presence: { message: 'must_be_present' }, length: { minimum: 8, message: 'too_short' }
    validates :first_name, presence: { message: 'must_be_present' }
    validates :last_name, presence: { message: 'must_be_present' }
  end
end