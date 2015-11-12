class Banana < ActiveRecord::Base
  validates :name, presence: true
end
