# Public: A root controller for the Admin Namespace
module Admin
  class AdminController < ::ApplicationController
    before_action :authenticate_admin!

    layout "admin/application"

    def dashboard
      render 'admin/dashboard'
    end

    def styleguide
      render 'admin/styleguide'
    end

    private

    def authenticate_admin!
    end
  end
end
