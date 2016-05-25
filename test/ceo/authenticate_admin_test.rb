require 'test_helper'

class Admin::AuthenticateAdminTest < ActionController::TestCase
  describe 'controller inheriting from AdminController' do
    before do
      @controller = Admin::ApplesController.new
    end

    it "calls #authenticate_admin!" do
      mock = MiniTest::Mock.new
      mock.expect(:call, false)

      @controller.stub(:authenticate_admin!, mock) do
        get :index
      end

      mock.verify
    end

    describe 'when #authenticate_admin! is not defined by app' do
      it 'returns false when calling #authenticate_admin!' do
        assert_equal false, @controller.authenticate_admin!
      end
    end

    describe 'when #authenticate_admin! is defined by app' do
      before do
        ApplicationController.class_eval do
          def authenticate_admin!
            "hi!"
          end
        end
      end

      after do
        ApplicationController.class_eval do
          remove_method :authenticate_admin!
        end
      end

      it 'defers to whatever the app defines as #authenticate_admin!' do
        assert_equal "hi!", @controller.authenticate_admin!
      end
    end
  end
end

