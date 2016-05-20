require 'test_helper'

describe 'apples admin pages' do
  include AcceptanceHelper
  describe 'new' do
    before do
      admin_page '/apples/new'
    end

    it 'should load' do
      assert_equal 200, page.status_code
    end

    it 'should create a new Apple' do
      fill_in 'apple[name]', with: 'Granny Smith'
      click_button 'Create Apple'
      assert_equal 200, page.status_code
    end
  end
end
