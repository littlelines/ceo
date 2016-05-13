require 'test_helper'

describe 'Apple admin pages' do
  include AcceptanceHelper

  describe 'index' do
    describe 'without apples' do
      it 'should not error' do
        admin_page '/apples'

        assert_equal 0, Apple.count
        assert page.has_content? 'There are no apples in the database.'
      end
    end

    describe 'with apples' do
      before do
        21.times { Apple.create }
        admin_page '/apples'
      end

      describe 'correct attributes' do
        let(:attributes) { Apple.new.attributes.keys }

        it 'should have the right number of headers' do
          headers = page.all('table thead th')
          assert_equal attributes.size + 2, headers.size # 2 function headers (edit & show)
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
        assert page.has_link? 'New Apple'
      end

      describe 'pagination' do
        it 'shows 20 apples per page' do
          assert_equal 20, page.all('table tbody tr').size
          refute_equal 20, Apple.count
        end

        describe 'pagination links' do
          describe 'first page' do
            it 'should have a disabled link' do
              assert el = find('ul li a', text: '1')
              assert el['href'].nil?
            end

            it 'should have a link to the next page' do
              assert all("a[href='/admin/apples/page/2']").length > 0
            end
          end

          describe 'second page' do
            before { visit '/admin/apples/page/2' }

            it 'should have a disabled link' do
              assert el = find('ul li a', text: '2')
              assert el['href'].nil?
            end

            it 'should have a first page button' do
              assert all("a[href='/admin/apples/page/1']").length > 0
            end
          end
        end
      end
    end
  end
end
