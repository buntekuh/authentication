require 'test_helper'

module Private
  class WelcomesControllerTest < ActionController::TestCase
    setup do
      @user = Users::CreateCommand.execute(Users::CreateForm.new(
        first_name: 'Hikaru', 
        last_name:  'Sulu', 
        email:      'hsulu@starfleet.ufp', 
        password:   'soSpooky'
      ))
    end

    test 'fails if user is not signed in' do
      assert_raises_with_message ActionController::RoutingError, 'unauthorized' do
        get :show
      end
    end

    test 'shows if user is signed in' do
      @controller.send :set_current_user, @user
      get :show
      assert_includes response.body, 'Welcome'
      assert_includes response.body, @user.first_name
      assert_includes response.body, @user.last_name
    end
  end
end
