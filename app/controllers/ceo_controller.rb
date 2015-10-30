module CEO
  # Public: A base controller for admin pages.
  #
  # Routing:
  #   Routing can be dple `resource` route.
  class AdminController < ApplicationController
    before_action :find_thing, only: [:show, :edit, :update, :destroy]
    before_action :confirm_authenticated

    def dashboard
      @backorders = Order.backorder
      @mismatches = Order.all
      render 'admin/dashboard'
    end

    # GET /things
    # Public: Indexes all things in the model.
    #
    # Uses pagination by default.
    #
    # Sets several variables and renders to a view.
    def index(options = {})
      options[:query] ||= []
      @page = (params[:page] || 1).to_i
      @route_name ||= @controller_name ||= controller_name

      @iterator = AdminIterator.new(thing,
        query: options[:query],
        page: @page,
        per_page: options.fetch(:per_page, 20),
        filters: {
          only: options[:only],
          except: options[:except]
        }
      )

      @things = @iterator.all || []
      @total_pages = @iterator.total_pages

      @model_name ||= thing.to_s.underscore
      @title = thing.to_s.titleize.pluralize
      render 'admin/index'
    end

    # GET /:things/:id
    def show(options = {})
      @thing_model = thing
      if options[:query]
        query_out = {}
        iterator = AdminIterator.new(thing)
        options[:query].each do |q|
          query_out.merge! iterator.query_eval(@thing, q)
        end
      end

      filtered_keys = AdminIterator.filter(keys(@thing), options)
      @thing_attrs = @thing.attributes.select do |k, _|
        filtered_keys.include? k
      end

      @thing_attrs.transform_keys! { |k| AdminIterator.acronymize(k) }
      @thing_attrs.merge! query_out if query_out

      render 'admin/show'
    end

    # GET /:things/new
    def new(options = { only: [], except: [:id, :created_at, :updated_at], required: [] })
      @thing_model = thing
      @thing = @thing_model.new
      @attrs = AdminIterator.filter(@thing.attributes.keys, options)
      @route_name ||= @controller_name ||= controller_name
      @index_route = send(:"admin_#{@route_name}_path")

      render 'admin/new'
    end

    # GET /:things/edit
    #
    # options - hash of options
    #   only - filter attributes to edit by whitelist
    #   except - filter attributes to edit by blacklist (has some preset defaults that you probably don't want)
    def edit(options = { only: [], except: [:id, :created_at, :updated_at], required: [] })
      @required_keys = options[:required]
      @attrs = AdminIterator.filter(@thing.attributes.keys, options)
      @model = @thing.model_name.name.constantize
      @route_name ||= @controller_name ||= controller_name
      @index_route = send(:"admin_#{@route_name}_path")

      render 'admin/edit'
    end

    # POST /:things
    def create
      @thing = thing.new(thing_params)
      @route_name ||= @controller_name ||= controller_name

      if @thing.save
        flash[:notice] = "#{thing} successfully created."
        redirect_to things_path(@route_name), notice: "#{thing.to_s.titleize} successfully created."
      else
        render 'admin/new'
      end
    end

    # PATCH/PUT /:things/:id
    def update
      @route_name ||= @controller_name ||= controller_name

      if @thing.update(thing_params)
        redirect_to things_path(@route_name), notice: "#{@controller_name.titleize} successfully updated."
      else
        render 'admin/edit'
      end
    end

    # DELETE /:things/:id
    def destroy
      @thing.destroy

      flash[:notice] = "#{thing} #{@thing.id} was successfully destroyed."
      redirect_to action: :index
    end

    private

    # Internal: Finds the ActiveRecord object of the current controller.
    #
    # Returns an ActiveRecord class.
    def thing
      controller_name.classify.constantize
    end

    # Private: Permits all model-defined parameters.
    #
    # Retuns a hash of parameters.
    def thing_params
      @params ||= thing.new.attributes.keys.map(&:to_sym)
      params.require(thing.name.underscore.to_sym).permit(
        @params,
        :page
      )
    end

    # Private: Finds an ActiveRecord object by id.
    #
    # Sets a variable `@thing`, which contains the object.
    def find_thing
      @thing = thing.find(params[:id])
    end

    # Private: Returns keys for a given model.
    #
    # Arguments:
    #   - model: the model object to get the keys from
    #
    # Returns an array of keys.
    def keys(model)
      model.attributes.keys
    end

    # Private: Returns the path of the thing.
    #
    # scope - an instance of a thing
    #
    # Returns the path of the thing.
    def thing_path(scope, pathname = @controller_name || controller_name)
      send(:"admin_#{pathname}_path", scope)
    end

    # Private: Returns the index path of a model.
    #
    # pathname - thing's name
    #
    # Returns the path of many things.
    def things_path(pathname)
      pathname ||= controller_name
      send(:"admin_#{pathname.pluralize}_path")
    end

    # @allowed can be used for additional params in child controllers

    def search_params
      @allowed = [:search_by, :search_term, :order_by, :direction, :page]
      params.permit(@allowed)
    end

    def processed_params
      SearchParamsHandler.new(search_params).processed_params
    end
  end
end
