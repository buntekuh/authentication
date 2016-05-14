module PresentationHelper
  #
  # Instantiates a presenter for the given context object
  # Expects that a class exists that that follows the patter: ContextClassPresenter
  # @example PagePresenter if the context object is a Page
  # @param context [context] The context to present
  # @param config = {} [Hash] configuration context to set in the presenter
  #
  # @return [type] [description]
  def present(context, config = {})
    presenter = BasePresenter.factory(context, self, config)
    yield presenter if block_given?
    presenter
  end
end