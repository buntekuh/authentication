#
# Presenters are used to move logic out of the view
# A presenter presents a single object or Array of like objects
# and pertains to a specific view object
# BasePresenter is an abstract class and should be inherited by a specific implementations
#
# @author [buntekuh]
#
class BasePresenter

  protected_attr_accessor :context, :config, :view

  #
  # @param context [Object] The object the presenter represents
  # @param view [] the erb template
  # @param config [Hash] configuration to be set on the presenter
  #
  # @return [type] [description]
  def initialize(_context, _view, _config = {})
    self.context = _context
    self.view = _view
    self.config = _config
  end

  #
  # Returns a presenter specific for the passed class
  # The class is guessed based on the class of the passed object
  # otherwise a :presenter may be passed in the config object
  # @param object [Object] the object to represent
  # @param view the erb template
  # @param config [Hash] configuration to be set on the presenter
  #
  # @return [type] [description]
  def self.factory(object, view, config = {})
    # if a specific presenter is named in config, use it
    if config[:presenter].present?
       klass = config.delete :presenter
    else
      # guess the class from the passed object
      if object.is_a?(Array)
        plural = 's'
        clazz = object.first.class.to_s
      else
        plural = ''
        clazz =  object.class.to_s
      end
      clazz.chomp! 'Form'
      klass = "#{clazz}#{plural}Presenter".constantize
    end
    klass.new(object, view, config)
  end


  #
  # @return [ActionView] The current view context
  def v
    @view
  end

  protected

  #
  # delegates methods to the view
  # @param *args [list of symbols] the names of the methods that should be passed to the view object
  #
  def self.delegate_to_view(*args)
    delegate *args, to: :view
  end

  delegate_to_view :current_user

  #
  # Allows a named method to be defined in a presenter class, that returns the context object
  # @example if the context object is a user we write:
  #   presents :user
  #   Then we could access user in a method:
  #   def name
  #     user.name
  #   end
  # @param name [String] The name of the method we wish to create
  #
  def self.presents(name)
    define_method(name) do
      @context
    end
  end
end
