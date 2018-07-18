module AdminMiddleware
  extend ActiveSupport::Concern

  # Will override admin/application layout
  # included do
  #   layout 'application'
  # end

  def foo_return
    foo
  end

  private

  def foo
    'bar'
  end
end
