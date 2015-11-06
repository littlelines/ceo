require 'test_helper'

class CEO::PaginatorTest < ActiveSupport::TestCase
  before do
    @apple_count = 10
    @per_page = 2
    @apple_count.times { Apple.create }
  end

  let(:paginator) do
    CEO::Paginator.new(
      Apple.limit(@apple_count),
      current_page: 1,
      per_page: @per_page
    )
  end

  describe 'with first page' do
    describe '#current_page' do
      it 'returns 1' do
        assert_equal 1, paginator.current_page
      end
    end

    describe '#next_page' do
      it 'returns 2' do
        assert_equal 2, paginator.next_page
      end
    end

    describe '#previous_page' do
      it 'returns 1 and does not decrement out of bounds' do
        assert_equal 1, paginator.previous_page
      end
    end

    describe '#has_previous?' do
      it 'returns false' do
        refute paginator.has_previous?
      end
    end

    describe '#has_next?' do
      it 'returns true' do
        assert paginator.has_next?
      end
    end

    describe '#to_a' do
      it 'returns paged model results from scope' do
        assert_equal 2, paginator.to_a.size
      end
    end

    describe '#total_pages' do
      it 'returns the total number of pages for the given scope' do
        assert_equal((@apple_count / @per_page), paginator.total_pages)
      end
    end

    describe '#total_results' do
      it 'returns the total number of results for the given scope' do
        assert_equal @apple_count, paginator.total_results
      end
    end

    describe '#intermediate_pages' do
      it 'returns an array of intermediate pages' do
        assert_equal [1, 2, 3], paginator.intermediate_pages(3)
      end

      it 'caps the intermediate pages to total number of pages' do
        paginator = CEO::Paginator.new(
          Apple.limit(@apple_count),
          current_page: 4,
          per_page: @per_page
        )
        assert_equal 5, paginator.total_pages
        assert_equal [3, 4, 5], paginator.intermediate_pages(3)
      end
    end
  end
end
