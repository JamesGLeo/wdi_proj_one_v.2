class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :dishname
      t.float :price
      t.string :course
      t.string :allergens
      t.string :calories

      t.timestamps
    end
  end
end
