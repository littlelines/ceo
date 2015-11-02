# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActiveSupport::TestCase.fixtures :all
end

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'capybara/rails'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

module TestHelper
  include Minitest::Spec::DSL
  include Capybara::DSL

  def admin_page(named_route)
    visit("/admin#{named_route}")
  end

  def admin_exists_for?(named_route)
    admin_page(named_route)
    assert_equal 200, page.status_code
  end
end

class ActiveSupport::TestCase
  include TestHelper
end
