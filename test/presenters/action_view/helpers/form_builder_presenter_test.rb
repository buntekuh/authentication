require 'test_helper'


module ActionView
  module Helpers
    
    class FormBuilderPresenterTestForm < BaseForm
      attribute :name
      def persisted?
        false
      end
    end

    class FormBuilderPresenterTest < ActionView::TestCase
      def get_presenter
        view.form_for(@context, url: '/') do |f|
          yield BasePresenter.factory f, view
        end
      end

      def setup
        @context = FormBuilderPresenterTestForm.new(name: 'boo')
      end

      test 'text_field' do
        get_presenter do |presenter|
          assert_includes presenter.text_field(:name), '<input type="text"'
          assert_includes presenter.text_field(:name), 'value="boo"'
        end
      end

      test 'password_field' do
        get_presenter do |presenter|
          assert_includes presenter.password_field(:name), '<input type="password"'
        end
      end

      test 'submit' do
        get_presenter do |presenter|
          assert_equal '<input type="submit" name="commit" value="ok" />', presenter.submit('ok')
        end
      end
    end
  end
end
