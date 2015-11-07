require 'test_helper'

describe 'show apples' do
  include AcceptanceHelper

  describe 'attributes' do
    let(:apple) { Apple.create(name: 'Granny Smith') }

    before do
      admin_page "/apples/#{apple.id}"
    end

    it 'should show proper header values' do
      table_headers = page.all('table tbody tr th').map(&:text)

      assert_includes table_headers, 'ID'
      assert_includes table_headers, 'Name'
    end

    it 'should show proper table values' do
      table_values = page.all('table tbody tr td').map(&:text)

      assert_includes table_values, apple.id.to_s
      assert_includes table_values, apple.name
    end
  end
end
