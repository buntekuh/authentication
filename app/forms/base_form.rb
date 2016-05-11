#
# Form objects are used to validate form input
# Abstract class, all Form implementations should inherit from BaseForm
#
# @author [buntekuh]
#
class BaseForm
  include Virtus.model

  extend ActiveModel::Naming
  extend ActiveModel::Callbacks
  include ActiveModel::Conversion
  include ActiveModel::Validations
end
