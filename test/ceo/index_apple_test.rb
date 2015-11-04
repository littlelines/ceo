require 'test_helper'

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

      it 'should have the right HTML IDs' do
        Apple.all.each do |a|
          page.has_css?("table tbody tr#apples-#{a.id}")
        end
      end

      it 'should have all IDs shown' do
        Apple.all.each do |a|
          page.has_css?('table tbody tr td', text: a.id.to_s)
        end
      end
    end
  end
end
