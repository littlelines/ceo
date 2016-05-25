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

    # Defers to #authenticate_admin! in ApplicationController if it is defined
    # If not, returns false/does nothing
    def authenticate_admin!
      super rescue false
    end
  end
end

