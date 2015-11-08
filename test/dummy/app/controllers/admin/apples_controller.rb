module AdminHelper
  private
  def foo
    'bar'
  end
end

module Admin
  class ApplesController < AdminController
    # CRUD!
    def show
      super(only: [:id, :name])
    end

    def foo_return
      foo
    end
  end
end
