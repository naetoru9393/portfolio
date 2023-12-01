class RemoveItemIdFromItem < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :item_id, :integer
  end
end
