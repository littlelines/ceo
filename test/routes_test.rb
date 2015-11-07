require 'test_helper'

describe 'routes' do
  include AcceptanceHelper

  describe 'apples' do
    def setup
      @apple = Apple.create(name: 'Granny Smith')
    end

    it 'index' do
      admin_exists_for? '/apples'
    end

    it 'new' do
      admin_exists_for? '/apples/new'
    end

    it 'show' do
      admin_exists_for? "/apples/#{@apple.id}"
    end

    it 'edit' do
      admin_exists_for? "/apples/#{@apple.id}/edit"
    end
  end
end
