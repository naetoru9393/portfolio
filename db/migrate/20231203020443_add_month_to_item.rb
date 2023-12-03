class AddMonthToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :month, :integer
  end
end
