module Auth
  module Concerns
      # 
      # Implements very simple but effective methods for user sign in
      # 
      # @author [buntekuh]
      # 
    module SessionMethods
      extend ActiveSupport::Concern

      # make certain methods available to the view layer
      included do
        helper_method :current_user, :signed_in?
      end

      protected

      #
      # Returns wether the user is signed in or not
      #
      # @return [true, false]
      def signed_in?
        current_user.present?
      end

      #
      # Returns the user that is currently signed in
      #
      # @return [User]
      def current_user
        @current_user ||= set_current_user_from_session
      end

      #
      # Sets the user in the session
      # @param user [User]
      #
      # @return [User] the signed in user
      def set_current_user(user)
        session[:session_token] = user.session_token
        @current_user = user
      end

      #
      # Reads the session and set the user if present
      #
      # @return [User] the signed in user
      def set_current_user_from_session
        return if session[:session_token].nil?
        user = User.find_by!(session_token: session[:session_token])
        set_current_user(user) if user.present?
      rescue
        sign_out # Do sign out if something goes wrong (ex: user doesn't exist anymore)
      end

      #
      # uses a token (usually supplied in a link) to sign in a user
      # the token is deleted after use
      #
      # @param token [String] valid token
      def sign_in_from_token token
        return unless token.present?

        if !signed_in?
          user = User.where(signon_token: token).first
          if user.present?
            set_current_user(user)
            user.update_column(:signon_token, nil)
          end
        end
      end

      #
      # Signs the user out
      #
      def sign_out
        session[:session_token] = @current_user = nil
      end
    end
  end
end
