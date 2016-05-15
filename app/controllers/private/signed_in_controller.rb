module Private
  #
  # Secure controller, requires user to be signed in
  #
  # @author [buntekuh]
  #
  class SignedInController < PresentedController
    before_filter :ensure_user_is_signed_in


    protected

    def ensure_user_is_signed_in
      raise ActionController::RoutingError.new(:unauthorized) unless signed_in?
    end
  end
end
