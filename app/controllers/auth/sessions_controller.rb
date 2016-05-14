module Auth
  #
  # Manages the user session
  #
  # @author [buntekuh]
  #
  class SessionsController < PresentedController

    # Displays the sign in form
    def new
      @form = UserPasswordAuthenticationForm.new
    end    
  end
end
