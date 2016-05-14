require 'test_helper'

class ABasePresenterTestObject;end
class ABasePresenterTestObjectPresenter < BasePresenter;end
class AnotherBasePresenterTestObjectPresenter < BasePresenter;end
class ABasePresenterTestObjectsPresenter < BasePresenter;end

class BasePresenterTest < ActionView::TestCase
  setup do
    @context = ABasePresenterTestObject.new
    @config = {foo:'bar'}
  end

  test 'it instantiates' do
    assert BasePresenter.new(@context, view, @config).is_a?(BasePresenter)
  end

  test 'factory returns a presenter' do
    assert BasePresenter.factory(@context, view).is_a? ABasePresenterTestObjectPresenter
  end

  test 'factory returns a presenter if given an Array' do
    assert BasePresenter.factory([@context], view).is_a? ABasePresenterTestObjectsPresenter
  end

  test 'factory returns a presenter defined in the config' do
    assert BasePresenter.factory(@context, view, {presenter: AnotherBasePresenterTestObjectPresenter}).is_a? AnotherBasePresenterTestObjectPresenter
  end

  test 'v' do
    assert_equal BasePresenter.new(@context, view, @config).v, view
  end

  test 'presents' do
    ABasePresenterTestObjectPresenter.send 'presents', :an_object
    assert ABasePresenterTestObjectPresenter.instance_methods.include?(:an_object)
    presenter = BasePresenter.factory(@context, view)
    assert_equal presenter.an_object, @context
  end

  test 'delegate_to_view' do
    ABasePresenterTestObjectPresenter.send 'delegate_to_view', :javascript_tag
    presenter = BasePresenter.factory(@context, view)
    assert_equal view.javascript_tag, presenter.javascript_tag
  end
end