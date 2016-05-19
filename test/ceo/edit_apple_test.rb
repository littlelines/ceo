require 'test_helper'

describe 'apples admin pages' do
  include AcceptanceHelper

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

  describe 'validation errors' do
    before do
      @banana = Banana.create(name: 'Dennis')
      visit "/admin/bananas/#{@banana.id}/edit"
    end

    it 'should error when validation is nil' do
      fill_in 'banana[name]', with: nil
      click_button 'submit'

      assert page.has_css?('.field_with_errors')
    end

    it 'should error when validation is empty' do
      fill_in 'banana[name]', with: ''
      click_button 'submit'

      assert page.has_css?('.field_with_errors')
    end
  end
end
