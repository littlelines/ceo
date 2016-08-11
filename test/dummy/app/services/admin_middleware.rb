module AdminMiddleware
  extend ActiveSupport::Concern

  included do
    layout 'application'
  end

  def foo_return
    foo
  end

  private

  def foo
    'bar'
  end
end
