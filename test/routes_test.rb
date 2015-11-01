require 'test_helper'

# class RoutesTest < ActiveSupport::TestCase
  describe 'routes' do
    include TestHelper

    it '/apples' do
      # visit('/admin/apples')
      # assert last_response.ok?
      admin_exists_for? '/apples'
    end
  end
# end
