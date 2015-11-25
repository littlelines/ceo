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

    it 'should allow passing a block to resources' do
      admin_exists_for? "/apples/#{@apple.id}/other_route"
    end

    it 'should allow passing of options' do
      admin_exists_for? "/not_obvious/responds_with_200"
    end
  end
end
