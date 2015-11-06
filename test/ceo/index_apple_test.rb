require 'test_helper'

describe 'Apple admin pages' do
  include AcceptanceHelper

  describe 'index' do
    before do
      30.times { Apple.create }
      admin_page '/apples'
    end

    it 'should not error when there are no apples' do
      Apple.delete_all
      admin_page '/apples'

      assert_equal 0, Apple.count
      expected_text = 'There are no apples in the database.'
      assert page.has_css?('p', text: expected_text)
    end

    describe 'correct attributes' do
      let(:attributes) { Apple.new.attributes.keys }

      it 'should have the right number of headers' do
        headers = page.all('table thead th')
        assert_equal attributes.size, headers.size
      end

      it 'should have the right header names' do
        assert page.has_css?('table thead tr th', text: 'ID')
        assert page.has_css?('table thead tr th', text: 'Name')
        assert page.has_css?('table thead tr th', text: 'Fruit')
      end

      it 'should have all IDs shown' do
        Apple.all.each do |a|
          page.has_css?('table tbody tr td', text: a.id.to_s)
        end
      end
    end

    it 'it should include a new button' do
      el = page.find('a#new-apple')
      assert_equal '/admin/apples/new', el['href']
      assert_equal 'New Apple', el.text
    end

    describe 'pagination' do
      it 'shows 20 apples per page' do
        assert_equal 20, page.all('table tbody tr').size
        refute_equal 20, Apple.count
      end

      describe 'pagination links' do
        describe 'first page' do
          it 'should have a disabled link' do
            el = page.find('nav ul li a', text: '1')
            assert_equal '1', el.text
            assert el['href'].nil?
          end

          it 'should have a link to the next page' do
            el = page.find('nav ul li a', text: '2')
            assert_equal '/admin/apples/page/2', el['href']
          end
        end

        describe 'second page' do
          before { visit '/admin/apples/page/2' }

          it 'should have a disabled link' do
            el = page.find('nav ul li a', text: '2')
            assert_equal '2', el.text
            assert el['href'].nil?
          end

          it 'should have a first page button' do
            el = page.find('nav ul li a', text: '1')
            assert_equal '/admin/apples/page/1', el['href']
          end
        end
      end
    end
  end
end
