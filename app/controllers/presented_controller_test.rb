require 'test_helper'

class PresentedControllerTest < ActionView::TestCase
  test 'present' do
    controller = PresentedController.new
    assert controller.respond_to? :present
  end
end