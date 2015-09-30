require 'test_helper'

module Multilang
  class TranslationKeysControllerTest < ActionController::TestCase
    test "should get create" do
      get :create
      assert_response :success
    end
  
  end
end
