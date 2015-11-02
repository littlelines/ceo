class CreateApple < ActiveRecord::Migration
  def change
    create_table :apples do |t|
      t.string :name
      t.integer :fruit_id
    end
  end
end
