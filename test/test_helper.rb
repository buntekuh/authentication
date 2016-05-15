ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# 
# A generic controller that allows us to test concerns, helpers, etc.
# 
# @author [buntekuh]
# 
class TestController < ApplicationController
  # allows us to pipe any method definition into the controller
  def initialize(method_name, &method_body)
    self.class.send(:define_method, method_name, method_body)
  end
end

class ActionController::TestCase
  # 
  # Setup temporary resource routes for the TestController
  # 
  def with_test_route
    with_routing do |set|
      set.draw do
        resources :test
      end
      yield
      Rails.application.routes_reloader.reload!
    end
  end

  # 
  # Assert that tests an Exception as well as a message
  # @param exception [Exception] The Exception to test
  # @param message [String] The message to test
  # @param &block [type] The block that should raise the exception and message
  # 
  def assert_raises_with_message(exception, message, &block)
    block.call
  rescue exception => e
    assert_match message, e.message
  end
end
