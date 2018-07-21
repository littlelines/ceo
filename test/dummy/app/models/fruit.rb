require 'ostruct'

class Fruit < ApplicationRecord
  has_many :apples

  def foo
    OpenStruct.new(bar: true)
  end
end
