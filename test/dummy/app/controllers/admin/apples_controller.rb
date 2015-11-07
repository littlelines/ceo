module Admin
  class ApplesController < AdminController
    # CRUD!
    def show
      super(only: [:id, :name])
    end
  end
end
