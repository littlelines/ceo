module CEO
  # Class to Paginate over active record scopes
  #
  # Ex:
  #
  #   Routes:
  #
  #     resources :users do
  #       collection do
  #         get 'page/:page', action: 'index', as: 'page', constraints: { page: /\d+/ }
  #       end
  #     en
  #
  #   Controller:
  #
  #     def index
  #       @users = Paginator.new(
  #         User.limit(100).order(name: :asc),
  #         current_page: params.fetch(:page, 1).to_i,
  #         per_page: 10
  #       )
  #     end
  #
  #
  #   View with `paginate` helper:
  #
  #     .row
  #       .large-12.columns
  #         = paginate @users, :admin_users_path, intermediate_pages: 6
  #
  #
  #   Simple View:
  #
  #   - if @order_paginator.has_previous?
  #     = link_to 'previous page', orders_path(page: @order_paginator.previous_page)
  #
  #   - if @order_paginator.has_next?
  #     = link_to 'next page', orders_path(page: @order_paginator.next_page)
  #
  class Paginator
    include Enumerable

    attr_accessor :scope, :current_page, :per_page

    # Constructor
    #
    # scope - The ActiveRecord scope to page over
    # current_page - The Number of the current page. >= 1
    # per_page - The number of records per page
    #
    def initialize(scope, options)
      @current_page = options.fetch :current_page
      @per_page = options.fetch :per_page
      @scope = scope
    end

    def has_previous?
      current_page.to_i > 1
    end

    def has_next?
      paged_scope.count == per_page
    end

    def multiple_pages?
      total_pages.to_i > 1
    end

    def next_page
      current_page.to_i + 1
    end

    def previous_page
      if current_page.to_i - 1 > 0
        current_page.to_i - 1
      else
        current_page.to_i
      end
    end

    def each
      paged_scope.each{|record| yield record }
    end

    def is_current_page?(page_number)
      current_page.to_i == page_number.to_i
    end

    def intermediate_pages(max = 5)
      floor = current_page - (max.to_f / 2).floor
      ceil = current_page + (max.to_f / 2).ceil
      floor = 1 if floor <= 0
      ceil = total_pages if ceil > total_pages

      floor.upto(ceil).collect{|page_num| page_num }
    end

    def total_results
      @total_results ||= scope.count
    end

    def total_pages
      @total_pages ||= (total_results.to_f / per_page).ceil
    end

    private

    def paging_offset
      return unless current_page

      (current_page.to_i - 1).abs * per_page
    end

    def paged_scope
      scope.offset(paging_offset).limit(per_page)
    end
  end
end
