require 'test_helper'

class Admin::ApplesControllerTest < ActionController::TestCase
  def setup
    @controller = Admin::ApplesController.new
  end

  describe 'GET #index' do
    it 'should be successful' do
      get :index
      assert_response :success
    end
  end

  describe 'GET #show' do
    let(:apple) { Apple.create(name: 'Granny Smith') }

    it 'should be successful' do
      get :show, params: { id: apple.id }
      assert_response :success
    end
  end

  describe 'GET #edit' do
    let(:apple) { Apple.create(name: 'Granny Smith') }

    it 'should be successful' do
      get :edit, params: { id: apple.id }
      assert_response :success
    end
  end

  describe 'GET #new' do
    it 'should be successful' do
      get :new
      assert_response :success
    end
  end

  describe 'helper methods' do
    it 'should be available in ApplesController' do
      assert_equal 'bar', @controller.foo_return
    end
  end
end
