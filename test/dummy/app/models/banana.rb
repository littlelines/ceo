class Banana < ActiveRecord::Base
  validates :name, presence: true

  enum stage: [:green, :ripe, :brown, :trash]
end

