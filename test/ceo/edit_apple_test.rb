require 'test_helper'

describe 'apples admin pages' do
  include TestHelper
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
end
