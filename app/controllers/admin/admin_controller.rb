# Public: A base controller for admin pages.
#
# Routing:
#   Routing can be dple `resource` route.
class Admin::AdminController < ApplicationController
  before_action :find_thing, only: [:show, :edit, :update, :destroy]

  helper_method :thing_path
  helper_method :things_path
  helper_method :new_thing_path
  helper_method :edit_thing_path
  helper_method :thing_page_path

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

    @iterator = CEO::Iterator.new(
      thing,
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
    @human_model = @model_name.humanize
    @title = thing.to_s.titleize.pluralize
    render 'admin/index'
  end

  # GET /:things/:id
  def show(options = {})
    @thing_model = thing
    if options[:query]
      query_out = {}
      iterator = CEO::Iterator.new(thing)
      options[:query].each do |q|
        query_out.merge! iterator.query_eval(@thing, q)
      end
    end

    filtered_keys = CEO::Iterator.filter(keys(@thing), options)
    @thing_attrs = @thing.attributes.select do |k, _|
      filtered_keys.include? k
    end

    @thing_attrs.transform_keys! { |k| CEO::Iterator.acronymize(k) }
    @thing_attrs.merge! query_out if query_out

    render 'admin/show'
  end

  # GET /:things/new
  def new(options = { only: [], except: [:id, :created_at, :updated_at], required: [] })
    @thing_model = thing
    @thing = @thing_model.new
    @attrs = CEO::Iterator.filter(@thing.attributes.keys, options)
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
    @attrs = CEO::Iterator.filter(@thing.attributes.keys, options)
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
  # object - An instance of a model.
  #
  # Returns the path of the thing.
  def thing_path(model, object)
    id = object['ID'] || object['id']
    send(:"admin_#{model.to_s.underscore.downcase}_path", id: id)
  end

  # Private: Returns the index path of a model.
  #
  # object - An instance of a model.
  #
  # Returns the path of many things.
  def things_path(object = nil)
    object ||= @route_name || controller_name
    send(:"admin_#{object.to_s.pluralize.downcase}_path")
  end

  # Private
  #
  # model - The model name.
  # object - An instance of a model.
  #
  # Returns the edit path of a model.
  def edit_thing_path(model, object)
    id = object['ID'] || object['id']
    send(:"edit_admin_#{model}_path", id: id)
  end

  # Private
  #
  # model - The model name.
  # object - An instance of a model.
  #
  # Returns the new path of a model.
  def new_thing_path(model, object)
    id = object['ID'] || object['id']
    send(:"new_admin_#{model}_path", id: id)
  end

  # Private
  #
  # model - The model name.
  # page - The page number.
  #
  # Returns the paginated path of an object.
  def thing_page_path(model, page)
    send(:"page_admin_#{model.to_s.underscore.pluralize}_path", page: page)
  end
end
