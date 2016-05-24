require 'test_helper'

class Admin::OrangesControllerTest < ActionController::TestCase
  def setup
    @controller = Admin::OrangesController.new
  end

  describe 'GET custom #index' do
    it 'should be successful' do
      get :index
      assert_response :success
    end
  end

  describe "GET CEO's #new" do
    it 'should break' do
      assert_raises { get :new }
    end
  end
end

