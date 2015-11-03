require 'test_helper'
require 'pry'

describe 'apples admin pages' do
  include TestHelper
  describe 'index' do
    before do
      admin_page '/apples'
    end

    describe 'correct attributes' do
      let(:attributes) { Apple.new.attributes.keys }
      let(:headers) { page.all('table thead th') }

      it 'should have the right number of headers' do
        assert_equal attributes.size, headers.size
      end

      it 'should have the right header names' do
        page.has_css?('table thead tr th', text: 'ID')
        page.has_css?('table thead tr th', text: 'Name')
        page.has_css?('table thead tr th', text: 'Fruit')
      end

      it 'should have all IDs shown' do
        Apple.all.each do |a|
          page.has_css?('table tbody tr td', text: a.id.to_s)
        end
      end
    end
  end

  describe 'edit' do
    before do
      @apple = Apple.create(name: 'Granny Smith')
      admin_page "/apples/#{@apple.id}/edit"
    end

    it 'should load the page' do
      assert_equal 200, page.status_code
    end

    it 'should edit apples' do
      apple_attrs = @apple.attributes

      apple_name = 'Red Delicious'
      fill_in 'apple[name]', with: apple_name
      click_button 'submit'
      assert_equal 200, page.status_code

      new_apple = Apple.find(@apple.id).attributes
      refute_equal new_apple, apple_attrs
      assert_equal apple_name, new_apple['name']
    end
  end

  describe 'it'
end
