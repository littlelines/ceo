class CreateBananas < ActiveRecord::Migration
  def change
    create_table :bananas do |t|
      t.string :name
      t.integer :stage

      t.timestamps null: false
    end
  end
end
