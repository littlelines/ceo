class CreateFruit < ActiveRecord::Migration
  def change
    create_table :fruits do |t|
      t.boolean :edible
    end
  end
end
