class AddApples < ActiveRecord::Migration
  def change
    create_table :apples do |t|
      t.string :name
    end
  end
end
