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

require 'maxitest/autorun'
require 'minitest/spec'
require 'capybara/rails'
require 'capybara/poltergeist'

module AcceptanceHelper
  extend Minitest::Spec::DSL
  include Capybara::DSL

  Capybara.javascript_driver = :poltergeist

  def admin_page(named_route)
    visit("/admin#{named_route}")
  end

  def admin_exists_for?(named_route)
    admin_page(named_route)
    assert_equal 200, page.status_code
  end

  def setup
    Apple.delete_all
  end

  def teardown
    Apple.delete_all
  end
end

class ActiveSupport::TestCase
  extend Minitest::Spec::DSL
end

class ActionController::TestCase
  extend Minitest::Spec::DSL
end
