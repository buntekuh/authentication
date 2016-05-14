require 'test_helper'

module Auth
  class SessionsControllerTest < ActionController::TestCase
    test 'new' do
      get :new
      assert_includes response.body, '<input type="text" name="session[email]"'
    end
  end
end
