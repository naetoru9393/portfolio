class Item < ApplicationRecord
    validates :item_name, :category_id, :user_id, presence: true
    validates :item_name, uniqueness: { scope: [:month, :user_id], message: "はすでに存在します" }
  end
  