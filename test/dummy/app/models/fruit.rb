require 'ostruct'

class Fruit < ActiveRecord::Base
  has_many :apples

  def foo
    OpenStruct.new(bar: true)
  end
end
