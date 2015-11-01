require 'action_dispatch/routing'
require 'active_support/concern'

module ActionDispatch::Routing
  class Mapper
    # Public: Generates default admin CRUD routes for resources.
    #
    # Returns a route.
    def admin_for(*rsrcs)
      rsrcs.map!(&:to_sym)

      concern :pageable do
        collection do
          get '/page/:page', action: :index, as: 'page'
        end
      end

      namespace :admin do
        rsrcs.each do |r|
          resources r, concerns: :pageable
        end
      end
    end
  end
end
