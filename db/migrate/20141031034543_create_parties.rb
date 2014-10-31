class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.integer :assigned_table
      t.integer :groupsize
      t.boolean :paid_check

      t.timestamps
    end
  end
end
