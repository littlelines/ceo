require 'action_dispatch/routing'
require 'active_support/concern'

module ActionDispatch::Routing
  class Mapper
    # Public: Generates default admin CRUD routes for resources.
    #
    # Returns a route.
    def admin_for(*rsrcs, &block)
      options = rsrcs.extract_options!
      rsrcs.map!(&:to_sym)

      concern :pageable do
        collection do
          get '/page/:page', action: :index, as: 'page'
        end
      end

      options[:concerns] = :pageable

      namespace :admin do
        get 'dashboard', to: 'admin#dashboard'
        get 'styleguide', to: 'admin#styleguide'
        rsrcs.each do |r|
          resources(r, options, &block)
        end
      end
    end
  end
end
