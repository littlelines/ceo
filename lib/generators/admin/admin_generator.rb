require 'rails/generators'

# Public: Generator for admin page controllers.
module CEO
  module Generators
    class AdminGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_admin_page_controller
        @controller = file_name
        template(
          'admin_page_controller.rb.erb',
          "app/controllers/admin/#{@controller.underscore}_controller.rb"
        )
      end

      def add_admin_route
        route "admin_for :#{@controller.underscore}"
      end

      def add_form_view
        unless Dir.exist?(Rails.root.join('app/views/admin'))
          Dir.mkdir(Rails.root.join('app/views/admin'))
        end

        create_file "app/views/admin/#{@controller.underscore}/_form.html.erb", <<VIEW
<% # "f" is exposed as a form object %>
VIEW
      end
    end
  end
end
