require 'test_helper'


class UserPresenterTest < ActionView::TestCase
  def setup
    @user = Users::CreateCommand.execute(Users::CreateForm.new(
      first_name: 'Hikaru', 
      last_name:  'Sulu', 
      email:      'hsulu@starfleet.ufp', 
      password:   'soSpooky'
    ))

    @presenter = BasePresenter.factory @user, view
  end

  test 'full_name' do
    assert_equal "#{@user.first_name}, #{@user.last_name}", @presenter.full_name
  end
end
