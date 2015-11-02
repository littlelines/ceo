require 'test_helper'

describe 'routes' do
  include TestHelper

  describe 'apples' do
    def setup
      Apple.create(name: 'Granny Smith')
    end

    it 'index' do
      admin_exists_for? '/apples'
    end

    it 'new' do
      admin_exists_for? '/apples/new'
    end

    it 'show' do
      admin_exists_for? '/apples/1'
    end

    it 'edit' do
      admin_exists_for? '/apples/1/edit'
    end
  end
end
