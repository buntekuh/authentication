require 'test_helper'

module Auth
  class SessionsControllerTest < ActionController::TestCase
    setup do
      @email        = 'hsulu@starfleet.ufp'
      @password     = 'soSpooky'
      Users::CreateCommand.execute(Users::CreateForm.new(
       first_name: 'Hikaru', 
        last_name:  'Sulu', 
        email:      @email, 
        password:   @password
      ))
      @controller.send :sign_out

    end

    test 'new' do
      get :new
      assert_includes response.body, '<input type="text" name="session[email]"'
    end

    test 'create signs in and redirects to inside controller' do
      post :create, session: { email: @email, password: @password }
      assert @controller.send('signed_in?')
      assert_equal @controller.send('current_user'), User.find_by_email(@email)
      assert_redirected_to welcome_path
    end

    test 'create redirects to new if credentials empty or wrong' do
      [{email: @email, password: ''}, {email: '', password: @password}, {email: nil, password: nil}].each do |params|
        post :create, session: params
        assert_not @controller.send('signed_in?')
        assert_not @controller.send('current_user')
        assert_redirected_to root_path(sign_in: 'failed', email: params[:email])
      end
    end
  end
end
