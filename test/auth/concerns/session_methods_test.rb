require 'test_helper'

class SessionMethodsTest < ActionController::TestCase
  setup do
    user_form = Users::CreateForm.new(first_name: 'Leonhard', last_name: 'McCoy', email: 'lmccoy@starfleet.ufp', password: 'bonesess')
    @user = Users::CreateCommand.execute user_form
  end

  test 'signed_in?' do
    @controller = TestController.new( :index ) { 
      render text: signed_in?.to_s
    }

    with_test_route do
      get :index
      assert_equal response.body, 'false'

      session[:session_token] = @user.session_token
      get :index
      assert_equal response.body, 'true'
    end

  end

  test 'current_user' do
    session[:session_token] = @user.session_token

    @controller = TestController.new( :index ) { 
    
      render text: current_user.first_name
    }

    with_test_route do
      get :index
      assert_equal response.body, @user.first_name
    end
  end

  test 'set_current_user?' do
    session[:session_token]

    @controller = TestController.new( :index ) { 
      set_current_user(User.find_by_email('lmccoy@starfleet.ufp')) 
      head :ok
    }

    with_test_route do
      get :index
      assert_equal session[:session_token], @user.session_token
    end
  end

  test 'set_current_user_from_session' do
    assert_not session[:session_token]
    session[:session_token] = @user.session_token

    @controller = TestController.new( :index ) { 
      set_current_user_from_session
      head :ok
    }

    with_test_route do
      get :index
      assert_equal session[:session_token], @user.session_token

      session[:session_token] = 'abc'
      get :index
      assert_not session[:session_token]
    end
  end

  test 'sign_in_from_token' do
    assert_not session[:session_token]
    @user.update_column(:signon_token, 'abc')

    @controller = TestController.new( :index ) { 
      sign_in_from_token(params[:token])
      head :ok
    }

    with_test_route do
      get :index, token: 'abc'
      assert_equal session[:session_token], @user.session_token
      assert_not @user.reload.signon_token
    end
  end

  test 'sign_out' do
    session[:session_token] = @user.session_token
    @controller = TestController.new( :index ) { 
      sign_out
      head :ok
    }

    with_test_route do
      get :index
      assert_not session[:session_token]
    end
  end
end
