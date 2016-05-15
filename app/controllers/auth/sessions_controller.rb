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

    #
    # Signs the user in or redirects back to the sign in form
    #
    def create
      begin
        @form = UserPasswordAuthenticationForm.new(params[:session])
        user = UserPasswordAuthenticationCommand.execute(@form)
        set_current_user(user)
        redirect_to welcome_path
      rescue UserPasswordAuthenticationCommand::InvalidCredentials, UserPasswordAuthenticationCommand::InvalidForm => e
        redirect_to root_path(email: @form.email, sign_in: 'failed')
      end
    end
  end
end
