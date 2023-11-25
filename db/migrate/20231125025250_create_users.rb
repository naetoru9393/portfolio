class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :user_id
      t.text :introduction
      t.integer :image

      t.timestamps
    end
  end
end
