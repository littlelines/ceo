module AdminMiddleware
  def foo_return
    foo
  end

  private

  def foo
    'bar'
  end
end
