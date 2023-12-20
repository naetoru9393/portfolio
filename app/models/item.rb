class Item < ApplicationRecord
    validates :item_name, :category_id, presence: true
    validates :item_name, uniqueness: { scope: :month }
end
