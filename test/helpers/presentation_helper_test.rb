require 'test_helper'

class APresentationHelperTestObject;end
class APresentationHelperTestObjectPresenter < BasePresenter;end

class PresentationHelperTest < ActionView::TestCase
  test 'present' do
    context = APresentationHelperTestObject.new

    present context do |presenter|
      assert presenter.is_a? APresentationHelperTestObjectPresenter
    end
  end
end