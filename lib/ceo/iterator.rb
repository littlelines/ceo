# Public: Iterator for listing out things.
class AdminIterator
  attr_reader :current_page, :total_pages

  # model   - The model to perform queries on.
  # options -
  #   query - An array of nested queries.
  #   filters - A hash of filters (only/except).
  def initialize(model, options = {})
    @model = model
    @options = options
    @queries = @options[:query] || []
    @filters = @options[:filters] || {}
  end

  # Public: Iterates through all parts.
  #
  # Yields or returns an Enumerator.
  def each
    if block_yielded?
      all.each do |thing|
        yield(thing)
      end
    else
      all.to_enum
    end
  end

  # Public: Returns a hash of titleized attributes mapped to their values.
  #
  # Uses pagination.
  #
  # options -
  #   current_page - currently paginated page
  #   per_page     - # of things to list per page
  #
  # Returns a paginated hash of data.
  def all
    attribute_maps = [] # [{...}, {...}]
    @pages = Paginator.new(
      @model,
      current_page: current_page,
      per_page: @options.fetch(:per_page, 20)
    )

    self.total_pages = @pages.total_pages

    @pages.each do |thing|
      attr_object = {}

      # TODO: Make all of this into a method.
      # map first-level values to a hash
      keys.each do |key|
        attr_object[AdminIterator.acronymize(key)] = thing[key.to_s]
      end

      # map nested values to a hash
      @queries.each do |query|
        attr_object.merge! query_eval(thing, query)
      end
      attribute_maps << attr_object
    end
    attribute_maps
  end

  # { 'Country Name' => 'South Korea' }
  def query_eval(scope, query)
    query_parts = query.split('.')
    if query_parts.length > 2
      title = AdminIterator.acronymize query_parts[-2..-1].join(' ')
      resp = 'None' if scope.instance_eval(query_parts[0]).nil? || scope.instance_eval(query_parts[0..1].join('.')).nil?
    elsif query_parts[-1] == 'name'
      title = AdminIterator.acronymize query_parts.join(' ')
      resp = 'None' if scope.instance_eval(query_parts[0]).nil?
    else
      title = AdminIterator.acronymize query_parts[-1]
      resp = 'None' if scope.instance_eval(query_parts[0]).nil?
    end

    resp = scope.instance_eval(query) unless resp == 'None'
    { title => resp }
  end

  # Public: Filters an enum based on a hash of params.
  #
  # things  - An enum of things to filter.
  # filters - A hash of filters (ALLOWED: [:only, :except]).
  #
  # Since 'only' and 'except' are mutually exclusive, 'only'
  # will be prefered over 'except'.
  #
  # Returns a hash of filtered keys.
  def self.filter(things, filters)
    return self.only(things, filters[:only]) unless filters[:only].nil? || filters[:only].empty?
    return self.except(things, filters[:except]) unless filters[:except].nil? || filters[:except].empty?

    return things # if nothing to filter, just return the things
  end

  # Public: Blacklists keys based on an array.
  #
  # blacklist - An array of keys that are not allowed.
  #
  # Examples
  #
  #   blacklist = [:this, :that]
  #   except([:this, :that, :here, :now], blacklist)
  #   # => [:here, :now]
  #
  # Returns a filtered hash of keys.
  def self.except(things, blacklist)
    blacklist = blacklist.map(&:to_s)
    things = things.map(&:to_s)
    things.select { |thing| !blacklist.include? thing }
  end

  # Public: Whitelists keys based on an array.
  #
  # whitelist - An array of keys that are only allowed.
  #
  # Examples
  #
  #   whitelist = [:this, :that]
  #   only([:this, :that, :here, :now], whitelist)
  #   # => [:this, :that]
  #
  # Returns a filtered hash of keys.
  def self.only(things, whitelist)
    whitelist = whitelist.map(&:to_s)
    things = things.map(&:to_s)
    things.select { |thing| whitelist.include? thing }
  end

  def current_page
    (@options[:current_page] || 1).to_i
  end

  # Public: Titleizes normal stuff, but upcases acronyms.
  def self.acronymize(key)
    parsed_key = key.to_s.titleize
    parsed_key = parsed_key.gsub 'Id', 'ID'
    parsed_key.gsub 'Iata Code', 'IATA'
  end

  private

  attr_writer :total_pages

  def keys
    singleton_class.send(:filter, @model.new.attributes.keys, @filters)
  end
end
