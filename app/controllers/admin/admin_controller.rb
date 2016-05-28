module Admin
  # Public: Base admin system controller. Contains authentication, a dashboard, and a
  # style guide. Anything that must affect all admin pages should be added here.
  class AdminController < ::ApplicationController
    # An AdminMiddleware module can be added to change any part of the
    # base AdminController class' functionality.
    try(:include, ::AdminMiddleware)

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

