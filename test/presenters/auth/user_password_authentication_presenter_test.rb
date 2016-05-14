require 'test_helper'


module Auth

  class UserPasswordAuthenticationPresenterTest < ActionView::TestCase
    def setup
      @context = UserPasswordAuthenticationForm.new
      @presenter = BasePresenter.factory @context, view
    end

    test 'form' do
      @presenter.form do |f|
        assert f.is_a? ActionView::Helpers::FormBuilderPresenter
      end
    end
  end
end
