class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :item_name
      t.integer :study_time
      t.integer :item_id
      t.integer :user_id
      t.integer :category_id
      t.integer :item_id

      t.timestamps
    end
  end
end
