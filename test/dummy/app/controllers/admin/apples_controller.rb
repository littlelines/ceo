module Admin
  class ApplesController < AdminController
    # CRUD!
    def show
      super(only: [:id, :name])
    end

    def other_route
      head 200
    end
  end
end
