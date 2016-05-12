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
end
